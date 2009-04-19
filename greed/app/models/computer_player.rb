class ComputerPlayer < ActiveRecord::Base
  def name
    logic.name
  end

  def description
    logic.description
  end

  def logic
    @logic ||= make_strategy
  end

  def make_strategy
    strategy.constantize.new
  end
end
