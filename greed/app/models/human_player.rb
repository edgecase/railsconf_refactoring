class HumanPlayer < ActiveRecord::Base
  belongs_to :game

  def description
    "Human"
  end
end
