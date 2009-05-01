class Turn < ActiveRecord::Base
  belongs_to :game
  # belongs_to :player # polymorphic
end
