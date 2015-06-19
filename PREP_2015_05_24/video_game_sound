#Son jeu video
use_bpm 200
base_unit = 2
use_synth :pulse

ronde = base_unit
blanche = ronde / 2.0
noire = blanche / 2.0
croche = noire / 2.0
doublecroche = croche / 2.0

define :zeldaRightHand do
  use_synth_defaults sustain: doublecroche /2 , release: doublecroche
  with_bpm 60 do
    #with_transpose 4 do
      2.times do
        play_pattern_timed [:g4,:a4,:b4,:cs5], [doublecroche]
      end
      2.times do
        play_pattern_timed [:gs4,:bb4,:c5,:d5], [doublecroche]
      end
      2.times do
        play_pattern_timed [:a4,:b4,:cs5,:ds5], [doublecroche]
      end
        play_pattern_timed [:b4,:cs5,:eb5,:f5], [doublecroche]
        play_pattern_timed [:c5,:d5,:e5,:fs5], [doublecroche]
        play_pattern_timed [:cs5,:eb5,:f5,:g5], [doublecroche]
        play_pattern_timed [:D5,:e5,:fS5,:gS5],[doublecroche]
    end
 # end
end

define :zeldaAccorditem do
  with_bpm 80 do
    with_transpose 4 do
      play_chord [:A4,:eb4] 
      sleep croche
      play_chord [:Bb4,:e4]
      sleep croche
      play_chord [:b4,:f4]
      sleep croche
      play_chord [:c5,:fs4]
      sleep ronde
    end
  end
end
define :zeldaItem do
  with_bpm 80 do
    with_transpose 4 do
      in_thread do
        play_pattern_timed [:A4,:Bb4,:b4,:c5], [croche,croche,croche,ronde]
      end
      in_thread do
        play_pattern_timed [:eb4,:e4,:f4,:fs4], [croche,croche,croche,ronde]
      end
      comment do
        in_thread do
          play_pattern_timed [:A3,:Bb3,:b3,:c4], [croche,croche,croche,ronde]
        end
      end
    end
  end
end

define :smallItem do
  with_bpm 80 do
    with_transpose 4 do
      in_thread do
        play_pattern_timed [:A5,:A5,:A5,:G4,:A5], [croche + doublecroche, doublecroche,doublecroche,doublecroche,ronde]
      end
      in_thread do
        play_pattern_timed [:f4,:F4,:f4,:d4,:e4], [croche + doublecroche, doublecroche,doublecroche,doublecroche,ronde]
      end
    end
  end
end

define :oneUpMushroom do
  play_pattern_timed [ :e4,:g4,:e5,:c5,:d5,:g5],[noire]
end

define :coin do
    play_pattern_timed [:b5,:e6],[croche, blanche]
end
define :powerUp do
  play_pattern_timed [ :g4,:b4,:d5,:g5,:b5, nil],[doublecroche]
  sleep noire
  play_pattern_timed [ :ab4,:c4,:eb5,:ab5,:c6, nil],[doublecroche]
  sleep noire
  play_pattern_timed [ :bb4,:d4,:f5,:bb5,:d6, nil],[doublecroche]
end

zeldaRightHand
zeldaItem
