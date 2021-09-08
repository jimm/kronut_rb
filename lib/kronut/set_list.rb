require_relative 'consts'
require_relative 'slot'

module Kronut
  class Kronos
    class SetList
      attr_accessor :name, :slots, :eq_bypass, :band_levels, :control_surface_mode,
                    :control_surface_assign_from, :reserved

      def self.from_bytes(bytes)
        set_list = SetList.new
        set_list.name = bytes[0, SET_LIST_NAME_LEN].reject { |b| b == 0 }.map(&:chr).join
        128.times do |i|
          start = SET_LIST_NAME_LEN + (i * SLOT_BYTE_SIZE)
          set_list.slots[i] = Slot.from_bytes(bytes[start, SLOT_BYTE_SIZE])
        end
        bytes = bytes[SET_LIST_NAME_LEN + 128 * SLOT_BYTE_SIZE..-1]
        set_list.eq_bypass = bytes[0] == 1
        set_list.band_levels = bytes[1, 9]
        set_list.control_surface_mode = bytes[10]
        set_list.control_surface_assign_from = bytes[11]
        set_list.slots_per_page = 16 >> bytes[12]
        set_list
      end

      def initialize
        @name = ''
        @slots = (0..127).map { |_| Slot.new }
        @eq_bypass = true
        @band_levels = [0] * 9
        @control_surface_mode = 0
        @control_surface_assign_from = 0
        @slots_per_page = 0     # 0 == 16, 1 == 8, 2 == 4
        @reserved = [0] * 3
      end

      def slots_per_page
        16 >> @slots_per_page
      end

      def slots_per_page=(val)
        case val
        when 16
          @slots_per_page = 0
        when 8
          @slots_per_page = 1
        when 4
          @slots_per_page = 2
        end
      end

      def to_bytes
        bytes = @name[0, SET_LIST_NAME_LEN].dup.bytes
        bytes += [0] * (SET_LIST_NAME_LEN - @name.length)
        @slots.each { |slot| bytes += slot.to_bytes }
        bytes << @eq_bypass ? 1 : 0
        bytes += @band_levels
        bytes << @control_surface_mode
        bytes << @control_surface_assign_from
        bytes << @slots_per_page
        bytes += @reserved
        bytes
      end
    end
  end
end
