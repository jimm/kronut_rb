require_relative 'consts'

module Kronut
  class Kronos
    # performance type
    #
    #  7 6 5 4 3 2 1 0
    #  |_| |_____| |_|
    # font  color  type
    # low 2
    # bits
    #
    #
    # performance bank
    #
    #  7 6 5 4 3 2 1 0
    #  |___| |_______|
    # xpose   perf bank
    # hi bits
    #
    #   perf bank:
    #     INT A - INT-F     = 0x00-0x05
    #     GM                = 0x06
    #     g(1) - g(9)       = 0x07-0x0f
    #     g(d)              = 0x10
    #     USER-A - USER-G   = 0x11-0x17
    #     USER-AA - USER-GG = 0x18-1E
    #
    # performance index
    #  (all bits used (?))
    #
    #
    # hold time
    #  (all bits used (?))
    #
    #
    # volume
    #  (all bits used)
    #
    #
    # keyboard track
    #
    #  7 6 5 4 3 2 1 0
    #  |___| | |_____|
    #  xpose |  kbd track
    #  low   |
    #       font high bit
    class Slot
      attr_accessor :name, :performance_type, :performance_bank, :performance_index,
                    :hold_time, :volume, :keyboard_track, :comments

      def self.from_bytes(bytes)
        slot = Slot.new
        slot.name = bytes[0, SLOT_NAME_LEN].reject { |b| b == 0 }.map(&:chr).join
        bytes = bytes[SLOT_NAME_LEN..-1]
        slot.performance_type = bytes[0]
        slot.performance_bank = bytes[1]
        slot.performance_index = bytes[2]
        slot.hold_time = bytes[3]
        slot.volume = bytes[4]
        slot.keyboard_track = bytes[5]
        bytes = bytes[6..-1]
        slot.comments = bytes.reject { |b| b == 0 }.map(&:chr).join
        slot
      end

      def initialize
        @name = ''
        @performance_type = 0
        @performance_bank = 0
        @performance_index = 0
        @hold_time = 0
        @volume = 0
        @keyboard_track = 0
        @comments = ''
      end

      def to_bytes
        bytes = @name[0, SLOT_NAME_LEN].dup.bytes
        bytes += [0] * (SLOT_NAME_LEN - @name.length)
        bytes << @performance_type
        bytes << @performance_bank
        bytes << @performance_index
        bytes << @hold_time
        bytes << @volume
        bytes << @keyboard_track
        bytes += @comments[0, SLOT_COMMENTS_LEN].dup.bytes
        bytes += [0] * (SLOT_COMMENTS_LEN - @comments.length)
        bytes
      end
    end
  end
end
