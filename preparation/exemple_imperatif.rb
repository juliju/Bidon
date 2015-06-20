# Exemple 1 :code imperatif
base_unit = 4
use_synth :tri
use_bpm 160



ronde = base_unit
blanche = ronde / 2.0
noire = ronde / 4.0
croche = ronde / 8.0
doublecroche = ronde / 16.0

accord = [:c4,:g4] 
noteB5 = [:b5]
noteE6 =[:e6]
silence = :rest

melody  = [[noteB5,croche], [noteE6,blanche], [silence,noire], [accord,ronde]]
melody2 = [[silence,noire],[accord,ronde],[noteB5,croche], [noteE6,blanche]]


# piano_main_droite = [:C5,:D5,:Bb4,:G4,:A4,:F4, 
#   :C4, :D4, :Bb3,:G3,:A3, :F3,
#   :C3,:D3, :Bb2,:G2,:Gb2,:F2,:rest,[:F4, :A3],:rest,
#   :rest,[:D3, :F3],:rest,:D3, :Ab3]



GrandPianoRightHandScore = [

#Bar 1
[:C5, croche], [:D5, croche],
[:Bb4, croche], [:G4, noire],
[:A4, croche],[:F4, noire],

#Bar 2
[:C4, croche],[:D4, croche],
[:Bb3, croche],[:G3, noire],
[:A3, croche],[:F3, noire],

#Bar 3
[:C3, croche],[:D3, croche],
[:Bb2, croche],[:G2,noire],
[:A2, croche],[:G2, croche],
[:Gb2, croche],

#Bar 4
[:F2, noire],[:rest, noire],
[[:F4, :A3], noire], [:rest, noire],

#Bar 5
[:rest, noire], [[:D3, :F3], noire],
[:rest, noire],[[:D3, :Ab3], noire],

#Bar 6
[:rest, noire],[[:Eb3, :G3], noire],
[:rest, noire],[[:D3, :F4], noire],

#Bar 7
[:rest, noire],[[:Bb3, :D3], noire],
[:rest, noire],[[:A3, :Eb3], noire],

#Bar 8
[:rest, noire],[[:D3, :F3], noire],

]


GrandPianoLeftHandScore = [

#Bar 1
[:rest, ronde],

#Bar 2
[:rest, ronde],

#Bar 3
[:rest, ronde],

#Bar 4
[:rest, blanche],
[:F2, noire],
[:rest, noire],

#Bar 5
[:Bb1, noire],[:rest, noire],
[:F2, noire],[:rest, noire],

#Bar 6
[:Eb2, noire],[:rest, noire],
[:D2, noire],[:rest, noire],

#Bar 7
[:F2, noire],[:rest, noire],
[:F2, noire],[:rest, noire],

#Bar 8
[:Bb1, noire],[:rest, noire],

]


ClarinetScore = [

#Bar 1
[:rest, ronde],

#Bar 2
[:rest, ronde],

#Bar 3
[:rest, ronde],

#Bar 4
[:rest, blanche],[:rest, noire],
[:C3, croche],[:Cs3, croche],

#Bar 5

[:D3,croche],[:Bb3,noire],
[:D3,croche],[:Bb3,noire],
[:D3,croche],[:Bb3,croche + blanche],

#Bar 6
# Tied above [:Bb3, blanche],
[:Bb3, croche],[:Bb3, croche],
[:C4, croche],[:Cs4, croche],

#Bar 7
[:D4, croche],[:Bb3, croche],
[:C4, croche],[:D4, noire],
[:A3, croche],[:C4, noire],

#Bar 8
[:Bb3, blanche],[:rest, noire],
]

#composition = [GrandPianoRightHandScore]

composition = [GrandPianoRightHandScore,GrandPianoLeftHandScore]
composition2 = [ClarinetScore]
#ClarinetScore

compositions = [GrandPianoRightHandScore,GrandPianoLeftHandScore ,ClarinetScore]
composition2 = [GrandPianoRightHandScore,GrandPianoLeftHandScore]
composition = [ClarinetScore]
#ClarinetScore
comment do
live_loop :tick do
  sleep base_unit
end
end

def PlayMelody(melody)
  for i in 0 ... melody.size
    play melody[i][0]
    sleep melody[i][1] 
  end
end

def Joueur (compositions)
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
  with_synth :pulse do
    PlayMelody(melody)
  end
end

Joueur(compositions)