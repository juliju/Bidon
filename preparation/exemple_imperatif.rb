# Exemple 1 :code imperatif
base_unit = 2
use_synth :pulse
use_bpm 100


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

in_thread do
  with_fx :level do
    for i in 0 ... melody.size
      play melody[i][0]
      sleep melody[i][1]
    end
  end
end


in_thread do
    with_fx :level do
      for i in 0 ... melody2.size
        play melody2[i][0]
        sleep melody2[i][1]
      end
    end
end