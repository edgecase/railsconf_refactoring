class AutoPlayer
  def self.players
    get_players.values
  end

  def self.register(player)
    get_players[player.name] = player
  end

  def self.[](name)
    get_players[name]
  end

  def self.clear
    @players.clear
  end

  def name
    self.class.name
  end

  def self.description
    "DESCRIPTION"
  end

  def roll_again?(*args)
    false
  end

  def self.get_players
    @players ||= {}
  end
end
