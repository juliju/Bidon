# Welcome to Sonic Pi v2.4

class Instrument
  def initialize (sonic_pi)
    @sonic_pi = sonic_pi
  end

  def play (arrayOfNotes, arrayOfTime)
    @sonic_pi.use_synth :pretty_bell
    @sonic_pi.play_pattern_timed arrayOfNotes , arrayOfTime
  end 
end

class Pulse < Instrument
  def initialize (sonic_pi)
    super(sonic_pi)
  end
  def play (arrayOfNotes, arrayOfTime)
    @sonic_pi.with_transpose  2 do
      super arrayOfNotes , arrayOfTime
    end  
  end
end


bell1 =  Instrument.new(self)
bell2 = Pulse.new(self)

in_thread do
 loop do
    sync :metronome
    bell1.play([:fs4,:e4,:d4,:cs4,:b3,:a3,:b3,:cs4],[1])
  end
end

in_thread do
 loop do
    sync :metronome
    sleep 9
    bell2.play([:fs4,:e4,:d4,:cs4,:b3,:a3,:b3,:cs4],[1])
  end
end

live_loop :metronome do
    sleep 9
end  # Welcome to Sonic Pi v2.5