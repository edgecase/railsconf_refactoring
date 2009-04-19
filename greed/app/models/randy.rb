class Randy < AutoPlayer
  def self.name
    "Randy"
  end

  def self.description
    "Random Player"
  end

  AutoPlayer.register(self)
end
