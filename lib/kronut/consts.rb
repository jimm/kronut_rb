KORG_MANUFACTURER_ID = 0x42
KRONOS_DEVICE_ID = 0x68

KRONOS_MODE_COMBINATION = 0
KRONOS_MODE_PROGRAM = 2
KRONOS_MODE_SEQUENCER = 4
KRONOS_MODE_SAMPLING = 6
KRONOS_MODE_GLOBAL = 7
KRONOS_MODE_DISK = 8
KRONOS_MODE_SET_LIST = 9

SET_LIST_BYTE_SIZE = 69_415
SET_LIST_NAME_LEN = 24

SLOT_BYTE_SIZE = 524
SLOT_NAME_LEN = 24
SLOT_COMMENTS_LEN = 512

FUNC_CODES = {
  obj_dump_req: 0x72,               # (R  ) Object Dump Request
  obj_dump: 0x73,                   # (R/T) Object Dump
  store_bank_req: 0x76,             # (R/T) Store Bank Request
  dump_bank_req: 0x77,              # (R  ) Dump Bank Request
  curr_obj_dump_req: 0x74,          # (R  ) Current Object Dump Request
  curr_obj_dump: 0x75,              # (R/T) Current Object Dump
  bank_digest_req: 0x37,            # (R  ) Bank Digest Request
  bank_digest: 0x38,                # (  T) Bank Digest
  bank_digest_collection_req: 0x39, # (R  ) Bank Digest Collection Request
  bank_digest_collection: 0x3A,     # (  T) Bank Digest Collection
  curr_sample_info_req: 0x30,   # (R  ) Current Sample Information Request
  curr_sample_info: 0x31,       # (  T) Current Sample Information
  curr_perf_id_req: 0x32,       # (R  ) Current Performance Id Request
  curr_perf_id: 0x33,           # (  T) Current Performance Id
  curr_piano_types_req: 0x34,   # (R  ) Current Piano Types Request
  curr_piano_types: 0x35,       # (  T) Current Piano Types
  notify_piano_types_changed: 0x36, # (  T) Notify Piano Types Changed
  smf_data_dump_req: 0x79,          # (R  ) SMF Data Dump Request
  smf_data_dump: 0x7A,              # (  T) SMF Data Dump
  param_change_int: 0x43,           # (R/T) Parameter Change (integer)
  parma_change_binary: 0x44,        # (R/T) Parameter Change (binary)
  seq_param_change: 0x41,           # (R/T) Sequencer Parameter Change
  karma_param_change: 0x6D,         # (R/T) KARMA Parameter Change
  drum_track_param_change: 0x6E,    # (R/T) Drum Track Parameter Change
  set_curr_obj: 0x71,               # (R/T) Set Current Object
  drum_kit_param_change_int: 0x53, # (R/T) Drum Kit Parameter Change (integer)
  drum_kit_param_change_binary: 0x54, # (R/T) Drum Kit Parameter Change (binary)
  wave_seq_param_change_int: 0x55, # (R/T) Wave Seq Parameter Change (integer)
  wave_seq_param_change_binary: 0x56, # (R/T) Wave Seq Parameter Change (binary)
  mode_req: 0x12,                     # (R  ) Mode Request
  mode_data: 0x42,                    # (  T) Mode Data
  mode_change: 0x4E,                  # (R/T) Mode Change
  prog_bank_types_req: 0x60,          # (R  ) Program Bank Types Request
  prog_bank_types: 0x61,              # (  T) Program Bank Types
  change_prog_bank_type: 0x7C,        # (R  ) Change Program Bank Type
  query_prog_bank_type: 0x7D, # (R  ) Query Program Bank Type (deprecated)
  query_prog_bank_type_reply: 0x7E, # (  T) Query Program Bank Type Reply (deprecated)
  reset_controller: 0x78,           # (R/T) Reset Controller
  karma_control: 0x7F,              # (R/T) KARMA Control
  song_select: 0x13,                # (R/T) Song Select
  reply: 0x24 # (  T) Reply
}

OBJ_TYPES = {
  program: 0x00, # Program (Prog_EXi_Common.txt, Prog_EXi.txt,
  # Prog_HD-1.txt)
  combination: 0x01,        # Combination (CombiAndSongTimbreSet.txt)
  song_timbre_set: 0x02,    # Song Timbre Set (CombiAndSongTimbreSet.txt)
  global: 0x03,             # Global (Global.txt)
  drum_kit: 0x04,           # Drum Kit (DrumKit.txt)
  wave_seq: 0x05,           # Wave Seq (WaveSequence.txt)
  karma_ge: 0x06,           # KARMA GE (NOTE: GEs are not edited on the
  # instrument, so there is no edit buffer)
  karma_template: 0x07,     # KARMA Template
  song_control: 0x08,       # Song Control (SongControl.txt)
  song_event: 0x09,         # Song Event (currently disabled)
  song_region: 0x0A,        # Song Region
  reserved: 0x0B,           # Reserved
  karma_ge_rtp_info: 0x0C,  # KARMA GE RTP Info (KARMA_GE_RTP.txt)
  set_list: 0x0D,           # Set List (index=set list) (SetList.txt)
  drum_track_pattern: 0x0E, # Drum Track Pattern (DrumTrackPattern.txt)
  drum_track_pattern_event: 0x0F, # Drum Track Pattern Event
  # (DrumTrackPatternEvent.txt)
  set_list_slot_comments: 0x10, # Set List Slot Comments (bank=set list, index=slot)
  set_list_slot_name: 0x11, # Set List Slot Name (bank=set list, index=slot)
  combi_name: 0x12,         # Combi Name
  program_name: 0x13,       # Program Name
  song_name: 0x14,          # Song Name
  wave_seq_name: 0x15,      # Wave Seq Name
  drum_kit_name: 0x16,      # Drum Kit Name
  set_list_name: 0x17,      # Set List Name (index=set list)
  song: 0x18 # Song (Song Timbre Set and Song Control in a
  # single object. Song.txt)
}

# MIDI constants.
module MIDI
  # Number of MIDI channels
  MIDI_CHANNELS = 16
  # Number of note per MIDI channel
  NOTES_PER_CHANNEL = 128

  #--
  # Standard MIDI File meta event defs.
  #++
  META_EVENT = 0xff
  META_SEQ_NUM = 0x00
  META_TEXT = 0x01
  META_COPYRIGHT = 0x02
  META_SEQ_NAME = 0x03
  META_INSTRUMENT = 0x04
  META_LYRIC = 0x05
  META_MARKER = 0x06
  META_CUE = 0x07
  META_MIDI_CHAN_PREFIX = 0x20
  META_TRACK_END = 0x2f
  META_SET_TEMPO = 0x51
  META_SMPTE = 0x54
  META_TIME_SIG = 0x58
  META_KEY_SIG = 0x59
  META_SEQ_SPECIF = 0x7f

  #--
  # Channel messages
  #++
  # Note, val
  NOTE_OFF = 0x80
  # Note, val
  NOTE_ON = 0x90
  # Note, val
  POLY_PRESSURE = 0xA0
  # Controller #, val
  CONTROLLER = 0xB0
  # Program number
  PROGRAM_CHANGE = 0xC0
  # Channel pressure
  CHANNEL_PRESSURE = 0xD0
  # LSB, MSB
  PITCH_BEND = 0xE0

  #--
  # System common messages
  #++
  # System exclusive start
  SYSEX = 0xF0
  # Beats from top: LSB/MSB 6 ticks = 1 beat
  SONG_POINTER = 0xF2
  # Val = number of song
  SONG_SELECT = 0xF3
  # Tune request
  TUNE_REQUEST = 0xF6
  # End of system exclusive
  EOX = 0xF7

  #--
  # System realtime messages
  #++
  # MIDI clock (24 per quarter note)
  CLOCK = 0xF8
  # Sequence start
  START = 0xFA
  # Sequence continue
  CONTINUE = 0xFB
  # Sequence stop
  STOP = 0xFC
  # Active sensing (sent every 300 ms when nothing else being sent)
  ACTIVE_SENSE = 0xFE
  # System reset
  SYSTEM_RESET = 0xFF

  # Controller numbers
  # = 0 - 31 = continuous, MSB
  # = 32 - 63 = continuous, LSB
  # = 64 - 97 = switches
  CC_BANK_SELECT_MSB = 0
  CC_MOD_WHEEL = 1
  CC_BREATH_CONTROLLER = 2
  CC_FOOT_CONTROLLER = 4
  CC_PORTAMENTO_TIME = 5
  CC_DATA_ENTRY_MSB = 6
  CC_VOLUME = 7
  CC_BALANCE = 8
  CC_PAN = 10
  CC_EXPRESSION_CONTROLLER = 11
  CC_GEN_PURPOSE_1 = 16
  CC_GEN_PURPOSE_2 = 17
  CC_GEN_PURPOSE_3 = 18
  CC_GEN_PURPOSE_4 = 19

  # [32 - 63] are LSB for [0 - 31]
  CC_BANK_SELECT_LSB = 0
  CC_DATA_ENTRY_LSB = 38

  #--
  # Momentaries:
  #++
  CC_SUSTAIN = 64
  CC_PORTAMENTO = 65
  CC_SUSTENUTO = 66
  CC_SOFT_PEDAL = 67
  CC_HOLD_2 = 69
  CC_GEN_PURPOSE_5 = 50
  CC_GEN_PURPOSE_6 = 51
  CC_GEN_PURPOSE_7 = 52
  CC_GEN_PURPOSE_8 = 53
  CC_TREMELO_DEPTH = 92
  CC_CHORUS_DEPTH = 93
  CC_DETUNE_DEPTH = 94
  CC_PHASER_DEPTH = 95
  CC_DATA_INCREMENT = 96
  CC_DATA_DECREMENT = 97
  CC_NREG_PARAM_LSB = 98
  CC_NREG_PARAM_MSB = 99
  CC_REG_PARAM_LSB = 100
  CC_REG_PARAM_MSB = 101

  #--
  # Channel mode message values
  #++
  # Val 0 == off, 0x7f == on
  CM_LOCAL_CONTROL = 0x7A
  CM_ALL_NOTES_OFF = 0x7B # Val must be 0
  CM_OMNI_MODE_OFF = 0x7C # Val must be 0
  CM_OMNI_MODE_ON = 0x7D  # Val must be 0
  CM_MONO_MODE_ON = 0x7E  # Val = # chans
  CM_POLY_MODE_ON = 0x7F  # Val must be 0

  # Controller names
  CONTROLLER_NAMES = [
    '0',
    'Modulation',
    'Breath Control',
    '3',
    'Foot Controller',
    'Portamento Time',
    'Data Entry',
    'Volume',
    'Balance',
    '9',
    'Pan',
    'Expression Control',
    '12', '13', '14', '15',
    'General Controller 1',
    'General Controller 2',
    'General Controller 3',
    'General Controller 4',
    '20', '21', '22', '23', '24', '25', '26', '27', '28', '29',
    '30', '31',
    '32', '33', '34', '35', '36', '37', '38', '39', '40', '41',
    '42', '43', '44', '45', '46', '47', '48', '49', '50', '51',
    '52', '53', '54', '55', '56', '57', '58', '59', '60', '61',
    '62', '63',
    'Sustain Pedal',
    'Portamento',
    'Sostenuto',
    'Soft Pedal',
    '68',
    'Hold 2',
    '70', '71', '72', '73', '74', '75', '76', '77', '78', '79',
    'General Controller 5',
    'Tempo Change',
    'General Controller 7',
    'General Controller 8',
    '84', '85', '86', '87', '88', '89', '90',
    'External Effects Depth',
    'Tremolo Depth',
    'Chorus Depth',
    'Detune (Celeste) Depth',
    'Phaser Depth',
    'Data Increment',
    'Data Decrement',
    'Non-Registered Param LSB',
    'Non-Registered Param MSB',
    'Registered Param LSB',
    'Registered Param MSB',
    '102', '103', '104', '105', '106', '107', '108', '109',
    '110', '111', '112', '113', '114', '115', '116', '117',
    '118', '119', '120',
    'Reset All Controllers',
    'Local Control',
    'All Notes Off',
    'Omni Mode Off',
    'Omni Mode On',
    'Mono Mode On',
    'Poly Mode On'
  ]

  # General MIDI patch names
  GM_PATCH_NAMES = [
    #--
    # Pianos
    #++
    'Acoustic Grand Piano',
    'Bright Acoustic Piano',
    'Electric Grand Piano',
    'Honky-tonk Piano',
    'Electric Piano 1',
    'Electric Piano 2',
    'Harpsichord',
    'Clavichord',
    #--
    # Tuned Idiophones
    #++
    'Celesta',
    'Glockenspiel',
    'Music Box',
    'Vibraphone',
    'Marimba',
    'Xylophone',
    'Tubular Bells',
    'Dulcimer',
    #--
    # Organs
    #++
    'Drawbar Organ',
    'Percussive Organ',
    'Rock Organ',
    'Church Organ',
    'Reed Organ',
    'Accordion',
    'Harmonica',
    'Tango Accordion',
    #--
    # Guitars
    #++
    'Acoustic Guitar (nylon)',
    'Acoustic Guitar (steel)',
    'Electric Guitar (jazz)',
    'Electric Guitar (clean)',
    'Electric Guitar (muted)',
    'Overdriven Guitar',
    'Distortion Guitar',
    'Guitar harmonics',
    #--
    # Basses
    #++
    'Acoustic Bass',
    'Electric Bass (finger)',
    'Electric Bass (pick)',
    'Fretless Bass',
    'Slap Bass 1',
    'Slap Bass 2',
    'Synth Bass 1',
    'Synth Bass 2',
    #--
    # Strings
    #++
    'Violin',
    'Viola',
    'Cello',
    'Contrabass',
    'Tremolo Strings',
    'Pizzicato Strings',
    'Orchestral Harp',
    'Timpani',
    #--
    # Ensemble strings and voices
    #++
    'String Ensemble 1',
    'String Ensemble 2',
    'SynthStrings 1',
    'SynthStrings 2',
    'Choir Aahs',
    'Voice Oohs',
    'Synth Voice',
    'Orchestra Hit',
    #--
    # Brass
    #++
    'Trumpet',
    'Trombone',
    'Tuba',
    'Muted Trumpet',
    'French Horn',
    'Brass Section',
    'SynthBrass 1',
    'SynthBrass 2',
    #--
    # Reeds
    #++
    'Soprano Sax', # 64
    'Alto Sax',
    'Tenor Sax',
    'Baritone Sax',
    'Oboe',
    'English Horn',
    'Bassoon',
    'Clarinet',
    #--
    # Pipes
    #++
    'Piccolo',
    'Flute',
    'Recorder',
    'Pan Flute',
    'Blown Bottle',
    'Shakuhachi',
    'Whistle',
    'Ocarina',
    #--
    # Synth Leads
    #++
    'Lead 1 (square)',
    'Lead 2 (sawtooth)',
    'Lead 3 (calliope)',
    'Lead 4 (chiff)',
    'Lead 5 (charang)',
    'Lead 6 (voice)',
    'Lead 7 (fifths)',
    'Lead 8 (bass + lead)',
    #--
    # Synth Pads
    #++
    'Pad 1 (new age)',
    'Pad 2 (warm)',
    'Pad 3 (polysynth)',
    'Pad 4 (choir)',
    'Pad 5 (bowed)',
    'Pad 6 (metallic)',
    'Pad 7 (halo)',
    'Pad 8 (sweep)',
    #--
    # Effects
    #++
    'FX 1 (rain)',
    'FX 2 (soundtrack)',
    'FX 3 (crystal)',
    'FX 4 (atmosphere)',
    'FX 5 (brightness)',
    'FX 6 (goblins)',
    'FX 7 (echoes)',
    'FX 8 (sci-fi)',
    #--
    # Ethnic
    #++
    'Sitar',
    'Banjo',
    'Shamisen',
    'Koto',
    'Kalimba',
    'Bag pipe',
    'Fiddle',
    'Shanai',
    #--
    # Percussion
    #++
    'Tinkle Bell',
    'Agogo',
    'Steel Drums',
    'Woodblock',
    'Taiko Drum',
    'Melodic Tom',
    'Synth Drum',
    'Reverse Cymbal',
    #--
    # Sound Effects
    #++
    'Guitar Fret Noise',
    'Breath Noise',
    'Seashore',
    'Bird Tweet',
    'Telephone Ring',
    'Helicopter',
    'Applause',
    'Gunshot'
  ]

  # GM drum notes start at 35 (C), so subtrack GM_DRUM_NOTE_LOWEST from your
  # note number before using this array.
  GM_DRUM_NOTE_LOWEST = 35
  # General MIDI drum channel note names.
  GM_DRUM_NOTE_NAMES = [
    'Acoustic Bass Drum',       # 35, C
    'Bass Drum 1',              # 36, C#
    'Side Stick',               # 37, D
    'Acoustic Snare',           # 38, D#
    'Hand Clap',                # 39, E
    'Electric Snare',           # 40, F
    'Low Floor Tom',            # 41, F#
    'Closed Hi Hat',            # 42, G
    'High Floor Tom',           # 43, G#
    'Pedal Hi-Hat',             # 44, A
    'Low Tom',                  # 45, A#
    'Open Hi-Hat',              # 46, B
    'Low-Mid Tom',              # 47, C
    'Hi Mid Tom',               # 48, C#
    'Crash Cymbal 1',           # 49, D
    'High Tom',                 # 50, D#
    'Ride Cymbal 1',            # 51, E
    'Chinese Cymbal',           # 52, F
    'Ride Bell',                # 53, F#
    'Tambourine',               # 54, G
    'Splash Cymbal',            # 55, G#
    'Cowbell',                  # 56, A
    'Crash Cymbal 2',           # 57, A#
    'Vibraslap',                # 58, B
    'Ride Cymbal 2',            # 59, C
    'Hi Bongo',                 # 60, C#
    'Low Bongo',                # 61, D
    'Mute Hi Conga',            # 62, D#
    'Open Hi Conga',            # 63, E
    'Low Conga',                # 64, F
    'High Timbale',             # 65, F#
    'Low Timbale',              # 66, G
    'High Agogo',               # 67, G#
    'Low Agogo',                # 68, A
    'Cabasa',                   # 69, A#
    'Maracas',                  # 70, B
    'Short Whistle',            # 71, C
    'Long Whistle',             # 72, C#
    'Short Guiro',              # 73, D
    'Long Guiro',               # 74, D#
    'Claves',                   # 75, E
    'Hi Wood Block',            # 76, F
    'Low Wood Block',           # 77, F#
    'Mute Cuica',               # 78, G
    'Open Cuica',               # 79, G#
    'Mute Triangle',            # 80, A
    'Open Triangle'             # 81, A#
  ]
end
