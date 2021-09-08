require 'optparse'
require 'portmidi'
require_relative 'editor'
require_relative 'kronos'

module Kronut
  class CLI
    def self.run
      new.run
    end

    def initialize
      @channel = 0
      @input_device_id = nil
      @output_device_id = nil
      @format = :org
      @set_list_num = nil
      @path = nil
      @command = :help
    end

    def run
      parse_command_line
      Portmidi.start
      case ARGV[0]
      when /\Ali/               # list
        list_devices
      when /\Alo/               # load
        find_kronos_device_ids
        editor = Editor.new(@format)
        set_list = editor.load_set_list(@path)
        kronos = Kronos.new(@channel, @input_device_id, @output_device_id)
        kronos.write_set_list(@set_list_num, set_list)
      when /\As/                # save
        find_kronos_device_ids
        kronos = Kronos.new(@channel, @input_device_id, @output_device_id)
        set_list = kronos.read_set_list(@set_list_num)
        editor = Editor.new(@format)
        editor.save_set_list(set_list, @path)
      end
    end

    private

    def parse_command_line
      OptionParser.new.load
      OptionParser.new do |opts|
        opts.banner = 'usage: kronut.rb [options] COMMAND'

        opts.on('-c', '--channel=CHANNEL', Integer, "Kronos MIDI channel (default: #{@channel + 1}") do |v|
          @channel = v - 1
        end

        default = @input_device_id || 'try to find it'
        opts.on('-i', '--input=DEVICE_ID', Integer, "PortMidi input device id (default: #{default})") do |v|
          @input_num = v
        end

        default = @output_device_id || 'try to find it'
        opts.on('-o', '--output=DEVICE_ID', Integer, "PortMidi output device id (default: #{default})") do |v|
          @output_num = v
        end

        opts.on('-f', '--format=FORMAT', %i[org markdown], "File format (default: #{@format})") do |v|
          @format = v.to_sym
        end

        default = @set_list_num || 'current set list'
        opts.on('-s', '--set-list=NUM', Integer, "Set list number (default: #{default})") do |v|
          @set_list_num = v
        end

        opts.on('-f', '--file=FILE', String, 'File to save/load (default: stdout/stdin)') do |v|
          @path = v
        end

        opts.on_tail('-h', '--help', help_string) do |_|
          puts opts
        end
      end.parse!(ARGV)
    end

    def find_kronos_device_ids
      device = Portmidi.input_devices.detect { |d| d.name.downcase == 'kronos keyboard' }
      @input_device_id = device.device_id if device

      device = Portmidi.output_devices.detect { |d| d.name.downcase == 'kronos sound' }
      @output_device_id = device.device_id if device
    end

    def help_string
      <<~EOS
        This help.

        Commands (unique prefixes accepted):

            list     List all attached MIDI devices.
            load     Load a set list from a file into the Kronos.
            save     Save a set list from the Kronos into a file.
      EOS
    end

    def list_devices
      puts 'Inputs:'
      Portmidi.input_devices.each do |device|
        puts "    #{'%3d' % device.device_id}  #{device.name}"
      end

      puts 'Outputs:'
      Portmidi.output_devices.each do |device|
        puts "    #{'%3d' % device.device_id}  #{device.name}"
      end
    end
  end
end
