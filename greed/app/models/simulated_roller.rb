class SimulatedRoller
  attr_reader :faces

  def initialize(data_source)
    @faces = []
    @data_source = data_source
  end

  def roll(n)
    roll = @data_source.shift
    if roll
      @faces = roll[0...n]
    else
      @faces = []
    end
  end
end
