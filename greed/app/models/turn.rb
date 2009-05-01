class Turn < ActiveRecord::Base
  belongs_to :game
  has_many :rolls
end
