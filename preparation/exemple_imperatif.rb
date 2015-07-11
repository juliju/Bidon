# Exemple 1 :code imperatif
base_unit = 4
use_synth :tri
use_bpm 120


  live_loop :TRIPLECROCHE do
    cueTick = 4.0 / 32.0
    sleep cueTick
  end


RONDE = 4.0
BLANCHE = RONDE / 2.0
NOIRE = RONDE / 4.0
CROCHE = RONDE / 8.0
DOUBLECROCHE = RONDE / 16.0
TRIPLECROCHE = RONDE / 32.0

def wait_TRIPLE_CROCHE()
  sync :TRIPLECROCHE
end

def wait_DOUBLECROCHE()
  wait_TRIPLE_CROCHE()
  wait_TRIPLE_CROCHE()
end

def wait_CROCHE()
  wait_DOUBLECROCHE()
  wait_DOUBLECROCHE()
end

def wait_NOIRE()
  wait_CROCHE()
  wait_CROCHE()
end

def wait_BLANCHE()
  wait_NOIRE()
  wait_NOIRE()
end

def wait_RONDE()
  wait_BLANCHE()
  wait_BLANCHE()
end


def mySweetSleep(duree)

  puts duree
  case duree
  when RONDE then wait_RONDE()
  when BLANCHE then wait_BLANCHE()
  when NOIRE then wait_NOIRE()
  when CROCHE then wait_CROCHE()
  when DOUBLECROCHE then wait_DOUBLECROCHE()
  when TRIPLECROCHE then wait_TRIPLECROCHE()
  end
end



GrandPianoRightHandScore = [

#Bar 1
[:C5, CROCHE], [:D5, CROCHE],
[:Bb4, CROCHE], [:G4, NOIRE],
[:A4, CROCHE],[:F4, NOIRE],

#Bar 2
[:C4, CROCHE],[:D4, CROCHE],
[:Bb3, CROCHE],[:G3, NOIRE],
[:A3, CROCHE],[:F3, NOIRE],

#Bar 3
[:C3, CROCHE],[:D3, CROCHE],
[:Bb2, CROCHE],[:G2,NOIRE],
[:A2, CROCHE],[:G2, CROCHE],
[:Gb2, CROCHE],

#Bar 4
[:F2, NOIRE],[:rest, NOIRE],
[[:F4, :A3], NOIRE], [:rest, NOIRE],

#Bar 5
[:rest, NOIRE], [[:D3, :F3], NOIRE],
[:rest, NOIRE],[[:D3, :Ab3], NOIRE],

#Bar 6
[:rest, NOIRE],[[:Eb3, :G3], NOIRE],
[:rest, NOIRE],[[:D3, :F4], NOIRE],

#Bar 7
[:rest, NOIRE],[[:Bb3, :D3], NOIRE],
[:rest, NOIRE],[[:A3, :Eb3], NOIRE],

#Bar 8
[:rest, NOIRE],[[:D3, :F3], NOIRE],

]


GrandPianoLeftHandScore = [

#Bar 1
[:rest, RONDE],

#Bar 2
[:rest, RONDE],

#Bar 3
[:rest, RONDE],

#Bar 4
[:rest, BLANCHE],
[:F2, NOIRE],
[:rest, NOIRE],

#Bar 5
[:Bb1, NOIRE],[:rest, NOIRE],
[:F2, NOIRE],[:rest, NOIRE],

#Bar 6
[:Eb2, NOIRE],[:rest, NOIRE],
[:D2, NOIRE],[:rest, NOIRE],

#Bar 7
[:F2, NOIRE],[:rest, NOIRE],
[:F2, NOIRE],[:rest, NOIRE],

#Bar 8
[:Bb1, NOIRE],[:rest, NOIRE],

]


ClarinetScore = [

#Bar 1
[:rest, RONDE],

#Bar 2
[:rest, RONDE],

#Bar 3
[:rest, RONDE],

#Bar 4
[:rest, BLANCHE],[:rest, NOIRE],
[:C3, CROCHE],[:Cs3, CROCHE],

#Bar 5

[:D3,CROCHE],[:Bb3,NOIRE],
[:D3,CROCHE],[:Bb3,NOIRE],
[:D3,CROCHE],[:Bb3,CROCHE],

#Bar 6
# Tied above [:Bb3, BLANCHE],
[:Bb3, BLANCHE],
[:Bb3, CROCHE],[:Bb3, CROCHE],
[:C4, CROCHE],[:Cs4, CROCHE],

#Bar 7
[:D4, CROCHE],[:Bb3, CROCHE],
[:C4, CROCHE],[:D4, NOIRE],
[:A3, CROCHE],[:C4, NOIRE],

#Bar 8
[:Bb3, BLANCHE]
]


def PlayMelody(melody)
  for i in 0 ... melody.size
    duree = melody[i][1]
    tonalite = melody[i][0]
     if tonalite.kind_of?(Array) then
      play_chord tonalite, release: duree
    else
      play tonalite, release: duree
    end
    mySweetSleep(duree) 
  end
end

def JoueurAleatoire (compositions)
  for i in 0 ... compositions.size
    in_thread do
      send([:playPiano,:playClarinet].choose, compositions.shift)
    end
  end
end

def playPiano (melody)
  with_fx :level do
    with_synth :tri do
      PlayMelody(melody)
    end
  end
end

def playClarinet(melody)
   for i in 0 ... melody.size
    duree = melody[i][1]
    tonalite = melody[i][0]
    synth :fm, note:tonalite, amp: 0.5, release: duree
    mySweetSleep melody[i][1]
  end
end

def playPrettyBell(melody)
 for i in 0 ... melody.size
    duree = melody[i][1]
    tonalite = melody[i][0]
    with_synth :pretty_bell do
      with_fx :wobble do
        play tonalite, attack: 0.01 , decay: 0, sustain: 0.1 * duree,
          release: 0.9*duree-0.01, amp: 1
        mySweetSleep duree
      end
    end
  end
end

def joueur(compositions)
  in_thread do
    playPiano(compositions.shift)
  end
  in_thread do
    playPiano(compositions.shift)
  end
  in_thread do
    playClarinet(compositions.shift)
  end
end

def joueur2(composition)
  in_thread do
    playPiano(composition.choose)
  end
end

ClarinetScore


composition = [GrandPianoRightHandScore]

compositions = [GrandPianoRightHandScore,GrandPianoLeftHandScore ,ClarinetScore]

joueur(compositions)