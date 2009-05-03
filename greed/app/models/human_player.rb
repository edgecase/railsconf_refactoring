class HumanPlayer < Player
  validates_length_of :name, :within => 1..32

  def description
    "Human"
  end

  def start_turn
    turn = Turn.new
    turns << turn
  end

  def roll_dice(dice_count=5)
    roller.roll(dice_count)
    accumulated_score = roller.points
    roll = Roll.new(
      :faces => roller.faces.map { |n| Face.new(:value => n) },
      :score => roller.points,
      :unused => roller.unused,
      :accumulated_score => accumulated_score)
    last_turn.rolls << roll
  end

  def holds
    self.score += last_turn.score
  end

  def rolls_again
    last_turn.rolls.last.action = :roll
    roll_dice(number_of_dice_to_roll)
  end

  private

  def number_of_dice_to_roll
    count = last_turn.rolls.last.unused
    (count == 0) ? 5 : count
  end
end
