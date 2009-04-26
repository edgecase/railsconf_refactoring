class HumanPlayer < ActiveRecord::Base
  belongs_to :game

  validates_length_of :name, :within => 1..32

  def description
    "Human"
  end
end
