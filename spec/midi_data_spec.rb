require_relative '../lib/kronut/midi_data'

MIDI_LETTERS = [
  0x40, 'a'.ord, 'b'.ord, 'c'.ord, 'd'.ord, 'e'.ord, 'f'.ord, 'g'.ord,
  0, 'h'.ord, 'i'.ord, 'j'.ord, 'k'.ord, 'l'.ord, 'm'.ord, 'n'.ord,
  0, 'o'.ord, 'p'.ord, 'q'.ord, 'r'.ord, 's'.ord, 't'.ord, 'u'.ord,
  0, 'v'.ord, 'w'.ord, 'x'.ord
]
INTERNAL_LETTERS = [
  'a'.ord, 'b'.ord, 'c'.ord, 'd'.ord, 'e'.ord, 'f'.ord, 'g'.ord + 0x80,
  'h'.ord, 'i'.ord, 'j'.ord, 'k'.ord, 'l'.ord, 'm'.ord, 'n'.ord,
  'o'.ord, 'p'.ord, 'q'.ord, 'r'.ord, 's'.ord, 't'.ord, 'u'.ord,
  'v'.ord, 'w'.ord, 'x'.ord
]

describe Kronut::MIDIData do
  describe 'midi to bytes' do
    let(:md) { Kronut::MIDIData.from_midi(MIDI_LETTERS) }

    it 'initializes properly' do
      expect(md.midi).to eq MIDI_LETTERS
    end

    it 'converts properly' do
      expect(md.bytes).to eq INTERNAL_LETTERS
    end
  end

  describe 'bytes to midi' do
    let(:md) { Kronut::MIDIData.from_bytes(INTERNAL_LETTERS) }

    it 'initializes properly' do
      expect(md.bytes).to eq INTERNAL_LETTERS
    end

    it 'converts properly' do
      expect(md.midi).to eq MIDI_LETTERS
    end
  end
end
