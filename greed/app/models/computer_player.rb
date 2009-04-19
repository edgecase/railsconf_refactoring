class ComputerPlayer < ActiveRecord::Base
  delegate :name, :description, :roll_again?, :to => :logic

  def logic
    @logic ||= make_strategy
  end

  def make_strategy
    strategy.constantize.new
  end
end
