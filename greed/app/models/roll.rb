class Roll < ActiveRecord::Base
  has_many :faces
  belongs_to :turn
end
