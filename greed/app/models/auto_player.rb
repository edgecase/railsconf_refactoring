class AutoPlayer
  def self.players
    @players.values
  end

  def self.register(player)
    @players ||= {}
    @players[player.name] = player
  end

  def self.[](name)
    @players[name]
  end

  def self.clear
    @players.clear
  end

  def self.load_auto_players
    Dir[File.join(RAILS_ROOT, 'app', 'models', 'auto_players', '*.rb')].each do |fn|
      load fn
    end
  end

  def name
    self.class.name
  end

  def roll_again?(*args)
    false
  end
end
