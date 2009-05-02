class Turn < ActiveRecord::Base
  has_many :rolls
  belongs_to :player
  acts_as_list :scope => :player
end
