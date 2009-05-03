class ComputerPlayer < Player

  delegate :name, :description, :roll_again?, :to => :logic
  attr_writer :logic

  def logic
    @logic ||= make_strategy
  end

  def take_turn
    history = []
    turn_score = 0
    roller.roll(5)
    loop do
      if roller.points == 0
        turn_score = 0
        bust(history, roller, turn_score)
        break
      end
      turn_score += roller.points
      if ! roll_again?
        hold(history, roller, turn_score)
        break
      end
      again(history, roller, turn_score)
      roller.roll(roller.unused)
    end
    turns << Turn.new(:score => turn_score, :rolls => history)
    save
    last_turn
  end
  
  private

  def again(history, roller, turn_score)
    record(history, roller, turn_score, :roll)
  end

  def hold(history, roller, turn_score)
    record(history, roller, turn_score, :hold)
  end

  def bust(history, roller, turn_score)
    record(history, roller, turn_score, :bust)
  end

  def record(history, roller, turn_score, action)
    roll = Roll.new(
      :faces => roller.faces.map { |n| Face.new(:value => n) },
      :score => roller.points,
      :unused => roller.unused,
      :accumulated_score => turn_score,
      :action => action)
    history << roll
  end

  def make_strategy
    strategy.constantize.new
  end
end
