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
noteE6=[:e6]
silence= [:rest]
accordSilence = ronde
noteB5Silence = croche
noteE6Silence = blanche
silenceSilence = noire

silence = [noteB5Silence,noteE6Silence, silenceSilence, accordSilence]
silence2 = [silenceSilence,accordSilence,noteB5Silence, noteE6Silence]
melody  = [noteB5,noteE6, silence, accord]
melody2 = [silence,accord,noteB5, noteE6]

in_thread do
  for i in 0 ... melody.size
    play melody[i]
    sleep silence[i]
  end
end

in_thread do
  
  for i in 0 ... melody.size
    play melody2[i]
    sleep silence2[i]
  end
  
end
