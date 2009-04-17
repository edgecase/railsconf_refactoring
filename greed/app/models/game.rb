class Game < ActiveRecord::Base
  has_one :web_player, :class_name => "Player"
end
