# Exemple 1 :code poo
$sonic_pi = self

class DureeMusicale
  @@duree

  def initialize (duree)
    @@duree = duree
    @sonic_pi =$sonic_pi
  end
  def play()
    @sonic_pi.sleep @@duree.get()
  end
end

  class Note < DureeMusicale
    def initialize(duree, tonalite)
      super duree
      @tonalite = tonalite
    end
    def play()
      @sonic_pi.play @tonalite
      super
    end
  end

class Accord < DureeMusicale
  def initialize(duree, *tonalites)
    super duree
    @tonalites = tonalites
  end

  def play()
   @sonic_pi.play_chord @tonalites
   super
  end
end

class Duree
  def initialize (ronde)
    @ronde = ronde
  end

  def ronde ()
    return self
  end
  
  def blanche ()
    return Duree.new(@ronde / 2.0)
  end

  def noire ()
    return Duree.new(@ronde / 4.0)
  end

  def croche ()
    return Duree.new(@ronde / 8.0)
  end

  def doubleCroche ()
    return Duree.new(@ronde / 16.0)
  end

  def get()
    return @ronde
  end
end


class Melodie
  def initialize (*durees_musicales)
    @durees_musicales = durees_musicales
  end
  def play()
     @durees_musicales.each do |duree_musicale|
      duree_musicale.play()
    end
  end
end

class CompositionMusicale

  def initialize(*melodies)
    @melodies = melodies 
    @sonic_pi = $sonic_pi
  end

  def play()
    @melodies.collect{
      |melodie| @sonic_pi.in_thread  do
        melodie.play()
        end
    }
  end
end

class Joueur
  def initialize()
    @sonic_pi = $sonic_pi
  end

  def joue(composition_musicale)
    composition_musicale.play()
  end
end

class JoueurToto < Joueur
  def initialize()
    super
  end

  def joue(composition_musicale)
    @sonic_pi.with_synth :pulse do
      @sonic_pi.with_bpm 200 do
        @sonic_pi.with_fx :level do
          composition_musicale.play()
    end
      end
    end
  end
end

class JoueurTata < Joueur
  def initialize()
    super
  end

  def joue(composition_musicale)
    @sonic_pi.with_synth :mod_sine do
      @sonic_pi.with_bpm 80 do
        @sonic_pi.with_fx :flanger do
          composition_musicale.play()
        end
      end
    end
  end
end



base_unit = 2
duree = Duree.new(base_unit)

accord = Accord.new(duree, :c4,:g4)

noteB = Note.new(duree.croche, :b5)
noteE = Note.new(duree.blanche, :e6)

silence = Note.new(duree.noire, :rest)

melody  = Melodie.new(noteB, noteE, silence, accord)
melody2 = Melodie.new(silence,accord,noteB, noteE)

composition_musicale = CompositionMusicale.new(melody, melody2)
joueur = JoueurToto.new()
joueur.joue composition_musicale
sleep 1
joueurTata = JoueurTata.new()
joueurTata.joue composition_musicale




