module Kronut
  class MIDIData
    def self.from_midi(midi_data)
      md = MIDIData.new
      md.midi = midi_data
      md
    end

    def self.from_bytes(bytes)
      md = MIDIData.new
      md.bytes = bytes
      md
    end

    def initialize
      @midi_bytes = []
      @internal_bytes = []
    end

    def midi
      @midi_bytes
    end

    def bytes
      @internal_bytes
    end

    def midi=(midi_bytes)
      @midi_bytes = midi_bytes
      @internal_bytes = []

      mlen = @midi_bytes.size
      midi_idx = 0
      internal_idx = 0

      while mlen > 0
        chunk_len = 8 > mlen ? mlen : 8
        (chunk_len - 1).times do |i|
          @internal_bytes[internal_idx + i] =
            @midi_bytes[midi_idx + i + 1] + (@midi_bytes[midi_idx] & (1 << i) != 0 ? 0x80 : 0)
        end
        midi_idx += chunk_len
        mlen -= chunk_len
        internal_idx += chunk_len - 1
      end
    end

    def bytes=(bytes)
      @internal_bytes = bytes
      @midi_bytes = []

      ilen = @internal_bytes.size
      internal_idx = 0
      midi_idx = 0

      while ilen > 0
        chunk_len = 7 > ilen ? ilen : 7
        @midi_bytes[midi_idx] = 0
        chunk_len.times do |i|
          b = @internal_bytes[internal_idx + i]
          @midi_bytes[midi_idx] += (1 << i) if (b & 0x80) != 0
          @midi_bytes[midi_idx + i + 1] = b & 0x7f
        end
        internal_idx += chunk_len
        ilen -= chunk_len
        midi_idx += chunk_len + 1
      end
    end
  end
end
