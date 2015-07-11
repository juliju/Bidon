use_synth :tri
use_bpm 60


live_loop :triplecroche do
  toto = 4.0 / 32.0
  sleep toto
end

ronde = 4.0
blanche = ronde / 2.0
noire = ronde / 4.0
croche = ronde / 8.0
doublecroche = ronde / 16.0
triplecroche = ronde / 32.0

def wait_triple_croche()
	sync :triplecroche
end

def wait_doublecroche()
	wait_triple_croche()
	wait_triple_croche()
end

def wait_croche()
	wait_doublecroche()
	wait_doublecroche()
end

def wait_noire()
	wait_croche()
	wait_croche()
end

def wait_blanche()
	wait_noire()
	wait_noire()
end

def wait_ronde()
	wait_blanche()
	wait_blanche()
end

in_thread do
  loop do
   # sample :drum_heavy_kick
    play :G4
    wait_noire()
  end
end

    in_thread do
     loop do
          play :C4
          wait_ronde()
        end
      end

    in_thread do
      loop do
          play :B5, release : doublecroche
          wait_doublecroche()
        end
      end




mesure(4, noire)
