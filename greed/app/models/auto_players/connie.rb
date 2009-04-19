class Connie < AutoPlayer
  def self.name
    "Connie"
  end

  def self.description
    "Conservative player"
  end

  AutoPlayer.register(self)
end
