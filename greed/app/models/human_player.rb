class HumanPlayer < Player
  validates_length_of :name, :within => 1..32

  def description
    "Human"
  end

  def start_turn
    turn = Turn.new
    turns << turn
  end

  def roll_dice
    roller.roll(5)
    accumulated_score = roller.points
    roll = Roll.new(
      :faces => roller.faces.map { |n| Face.new(:value => n) },
      :score => roller.points,
      :unused => roller.unused,
      :accumulated_score => accumulated_score)
    last_turn.rolls << roll
  end
end
