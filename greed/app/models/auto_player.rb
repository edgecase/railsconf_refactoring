class AutoPlayer
  def self.players
    get_players.values
  end

  def self.register(player)
    get_players[player.name] = player
  end

  def self.[](name)
    load_auto_players
    get_players[name]
  end

  def self.clear
    @players.clear
  end

  def self.load_auto_players
    return unless get_players.empty?
    Dir[File.join(RAILS_ROOT, 'app', 'models', 'auto_players', '*.rb')].each do |fn|
      load fn
    end
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
