use_synth :sine
use_bpm 100
def percu(tonalites, durees)
  max_release = 0.15
  min_release = 0.01
  max_dur = durees.max
  min_dur = durees.min
  coeff = max_dur > max_release ? max_release/max_dur : 1
  coeff = min_dur < min_release ? min_release/min_dur : coeff
  for i in 0 ... tonalites.size
    with_synth :noise do
      with_fx :reverb, mix: 0.2 do
        with_fx :echo, mix: 0.02 do
          duree=durees[i]
          play tonalites[i], attack: 0,
            decay: 0, sustain: 0,
            release: coeff * duree
          sleep duree
        end
      end
    end
  end
end
in_thread do
  #percu([:A4, :Bb4, :b4, :c5],  [0.25, 0.25, 0.25, 0.5])
  percu(scale(:C4, :major), [0.25, 0.25, 0.25, 0.5,0.25, 0.25, 0.25, 0.5])
  #percu([:D4, :E4, :C4, :C3, :G3],  [0.25, 0.25, 0.25, 0.25, 0.25])
end
comment do
use_synth :noise
with_fx :reverb, mix: 0.2 do
  loop do
    play scale(:Eb2, :major_pentatonic, num_octaves: 3).choose, release: 0.1, amp: rand
    sleep 0.1
  end
end
end
