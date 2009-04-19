class ComputerPlayer < ActiveRecord::Base
  def description
    logic.description
  end

  def logic
    @logic ||= AutoPlayer[name]
  end
end
