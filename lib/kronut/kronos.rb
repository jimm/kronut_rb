require 'portmidi'
require_relative 'consts'
require_relative 'midi_data'
require_relative 'set_list'
require_relative 'slot'

module Kronut
  class Kronos
    SYSEX_START_TIMEOUT_SECONDS = 5
    SYSEX_READ_TIMEOUT_SECONDS = 60
    TIMEOUT_ERROR_REPLY = 100
    ERROR_REPLY_MESSAGES = {
      0 => 'no error',
      1 => 'parameter type specified is incorrect for current mode',
      2 => 'unknown param message type, unknown parameter id or index',
      3 => 'short or otherwise mangled message',
      4 => 'target object not found',
      5 => 'insufficient resources to complete request',
      6 => 'parameter value is out of range',
      7 => '(internal error code)',
      64 => 'other error: program bank is wrong type for received program dump (Func 73, 75); invalid data in Preset Pattern Dump (Func 7B).',
      65 => 'target object is protected',
      66 => 'memory overflow',
      :unknown => '(unknown error code)',
      # The following errors are kronut errors, not Kronos errors
      :timeout => 'timeout'
    }

    def initialize(channel, in_device_id, out_device_id)
      @channel = channel
      @input = Portmidi::Input.new(in_device_id)
      @output = Portmidi::Output.new(out_device_id)
    end

    def write_set_list(n, set_list)
      goto_set_list(n)

      midi_data = MIDIData.from_bytes(set_list.to_bytes)
      request_sysex = [
        MIDI::SYSEX, KORG_MANUFACTURER_ID, 0x30 + @channel, KRONOS_DEVICE_ID,
        FUNC_CODES[:obj_dump], OBJ_TYPES[:set_list], 0
      ]
      request_sysex += midi_data.midi
      request_sysex << MIDI::EOX
      get(request_sysex, 'write_set_list')
    end

    def read_set_list(n)
      goto_set_list(n)

      request_sysex = [
        MIDI::SYSEX, KORG_MANUFACTURER_ID, 0x30 + @channel, KRONOS_DEVICE_ID
      ]
      request_sysex += if n
                         [
                           FUNC_CODES[:obj_dump_req], OBJ_TYPES[:set_list],
                           0, (n >> 7) & 0x7f, n & 0x7f
                         ]
                       else
                         [
                           FUNC_CODES[:curr_obj_dump_req], OBJ_TYPES[:set_list],
                           MIDI::EOX
                         ]
                       end
      get(request_sysex, 'read_set_list')

      midi_data = MIDIData.from_midi(@sysex[7..-1])

      SetList.from_bytes(midi_data.bytes)
    end

    def goto_set_list(n)
      set_list_mode
      messages = [
        { message: [MIDI::CONTROLLER + @channel, MIDI::CC_BANK_SELECT_MSB, 0], timestamp: 0 },
        { message: [MIDI::CONTROLLER + @channel, MIDI::CC_BANK_SELECT_LSB, n], timestamp: 0 },
        { message: [MIDI::PROGRAM_CHANGE + @channel, 0, n], timestamp: 0 }
      ]
      @output.write(messages)
    end

    def set_list_mode
      request_sysex = [
        MIDI::SYSEX, KORG_MANUFACTURER_ID, 0x30 + @channel, KRONOS_DEVICE_ID,
        FUNC_CODES[:mode_change], KRONOS_MODE_SET_LIST, MIDI::EOX
      ]
      get(request_sysex, 'set_list_mode')
    end

    private

    def get(sysex, func_name)
      send_sysex(sysex)
      read_sysex
      raise "Kronos##{func_name} received an error response: #{error_reply_message}" if error_reply_seen?
    end

    def send_sysex(sysex)
      @output.write_sysex(sysex)
    end

    def read_sysex
      @sysex = []
      state = :waiting
      start = Time.now
      while state != :received && state != :error
        if @input.poll
          events = @input.read(1024)
          events.each do |event|
            event[:message].each do |b|
              case b
              when MIDI::SYSEX
                state = :receiving
                @sysex << b
              when MIDI::EOX
                @sysex << b
                state = :received
              when 0xf1..0xff
                # ignore realtime
              when 0x80..0xef
                state = :error
              else
                @sysex << b if state == :receiving
              end
            end
          end
        elsif state == :waiting && (Time.now - start) >= SYSEX_START_TIMEOUT_SECONDS
          raise 'timeout waiting for sysex'
        elsif state == :receiving && (Time.now - start) >= SYSEX_READ_TIMEOUT_SECONDS
        end
      end
    end

    def error_reply_seen?
      @sysex[4] == FUNC_CODES[:reply] && @sysex[5] > 0
    end

    def error_reply_message
      error = @sysex[5]
      return ERROR_REPLY_MESSAGES[error] if ERROR_REPLY_MESSAGES.has_key?(error)

      # We don't yet set TIMEOUT_ERROR_REPLY, but might
      key = error == TIMEOUT_ERROR_REPLY ? :timeout : :unknown
      ERROR_REPLY_MESSAGES[key]
    end
  end
end
