# Exemple 1 :code imperatif
use_bpm 60
base_unit = 2
#use_synth :pulse

ronde = base_unit
blanche = ronde / 2.0
noire = blanche / 2.0
croche = noire / 2.0
doublecroche = croche / 2.0

music_to_play = [:c4,:g4]

in_thread do
  play :C4
  sleep noire
  play :rest
  sleep noire
  play_chord music_to_play
  sleep noire
end

in_thread do
  with_fx :bitcrusher do
    play :rest
    sleep noire
    play_chord music_to_play
    sleep noire
    play :C4
    sleep noire
  end
end