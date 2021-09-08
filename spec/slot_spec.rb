require_relative '../lib/kronut/consts'
require_relative '../lib/kronut/kronos'

describe Kronut::Kronos::Slot do
  def slot_bytes
    bytes = 'abcde'.bytes
    bytes += [0] * (SLOT_NAME_LEN - 5)
    bytes << 0x71               # perf type
    bytes << 0x72               # perf bank
    bytes << 0x73               # perf index
    bytes << 0x06               # hold time
    bytes << 0x7f               # volume
    bytes << 0                  # keyboard track
    bytes += 'vwxyz'.bytes
    bytes += [0] * (SLOT_COMMENTS_LEN - 5)
    bytes
  end

  describe '.from_bytes' do
    it 'parses bytes correctly' do
      bytes = slot_bytes
      expect(slot_bytes.length).to eq SLOT_NAME_LEN + 6 + SLOT_COMMENTS_LEN # sanity check

      slot = Kronut::Kronos::Slot.from_bytes(bytes)
      expect(slot.name).to eq 'abcde'
      expect(slot.performance_type).to eq 0x71
      expect(slot.performance_bank).to eq 0x72
      expect(slot.performance_index).to eq 0x73
      expect(slot.hold_time).to eq 0x06
      expect(slot.volume).to eq 0x7f
      expect(slot.keyboard_track).to eq 0
      expect(slot.comments).to eq 'vwxyz'
    end
  end

  describe '#to_bytes' do
    it 'turns slot into bytes correctly' do
      slot = Kronut::Kronos::Slot.new
      slot.name = 'abcde'
      slot.performance_type = 0x71
      slot.performance_bank = 0x72
      slot.performance_index = 0x73
      slot.hold_time = 0x06
      slot.volume = 0x7f
      slot.keyboard_track = 0
      slot.comments = 'vwxyz'

      expect(slot.to_bytes).to eq slot_bytes
    end
  end
end
