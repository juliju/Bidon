use_synth :tri
use_bpm 60


live_loop :triplecroche do
  toto = 4.0 / 32.0
  sleep toto
end

RONDE = 32 * TRIPLECROCHE
BLANCHE = 16 * TRIPLECROCHE
NOIRE = 8 * TRIPLECROCHE
CROCHE = 4* TRIPLECROCHE
DOUBLECROCHE = 	2 * TRIPLECROCHE
TRIPLECROCHE = 1

def my_sweet_wait(duree)
	for	i in 1 ... duree
		sync: triplecroche
	end	
end




in_thread do
	loop do
	# sample :drum_heavy_kick
	play :G4, release: NOIRE 
	my_sweet_wait(NOIRE)
	end
end


in_thread do
	loop do
	  play :C4, release: RONDE
	  my_sweet_wait(RONDE)
	end
end


in_thread do
loop do
  play :B5, release: DOUBLECROCHE
    my_sweet_wait(DOUBLECROCHE)
end
end




mesure(4, noire)
