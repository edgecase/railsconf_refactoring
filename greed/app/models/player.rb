class Player < ActiveRecord::Base
  belongs_to :game
  has_many :turns

  def last_turn
    turns.last
  end
end
