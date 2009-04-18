class Randy < AutoPlayer
  def self.name
    "Randy"
  end

  AutoPlayer.register(self)
end
