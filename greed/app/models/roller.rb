class Roller
  attr_reader :faces
  
  def initialize
    @faces = []
    @scorer = Scorer.new
  end
  
  def roll(n)
    @faces = random_faces(n)
    @scorer.score(@faces)
  end
  
  def points
    @scorer.points
  end
  
  def unused
    @scorer.unused
  end
  
  private
  
  def random_faces(n)
    (1..n).map { rand(6) + 1 }
  end
end
