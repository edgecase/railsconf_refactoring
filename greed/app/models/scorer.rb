class Scorer
  attr_reader :points, :unused

  def score(roll)
    @unused = 0
    @points = 0
    (1..6).each do |face|
      face_score(roll, face)
    end
  end

  private
  
  def face_score(roll, face)
    count = face_count(roll, face)
    if count >= 3
      score_triples(face)
      count -= 3
    end
    score_singles(face, count)
  end
  
  def score_triples(face)
    if face == 1
      @points += 1000
    else
      @points += 100 * face
    end
  end
  
  def score_singles(face, count)
    if face == 5
      @points += 50 * count
    elsif face == 1
      @points += 100 * count
    else
      @unused += count
    end
  end
  
  def face_count(roll, face)
    roll.select { |n| n == face }.size
  end
end
