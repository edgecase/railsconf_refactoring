class Game < ActiveRecord::Base
  has_one :human_player, :class_name => "Player"
  has_many :players
end
