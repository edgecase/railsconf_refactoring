require 'test_helper'

class RollerTest < Test::Unit::TestCase
  def setup
    @roller = Roller.new
  end

  def test_roll_rolls_n_dice
    assert_equal 2, roll_size(2)
    assert_equal 5, roll_size(5)
  end

  def test_randomly_distributed
    collect_face_counts.each do |face, count|
      assert_tween 1, 6, face, "face"
      assert_tween 800, 1200, count, "count"
    end
  end

  def test_calculates_score
    def @roller.random_faces(n)
      @faces = [1, 5, 2, 3, 2]
    end

    @roller.roll(5)

    assert_equal 150, @roller.points
    assert_equal 3, @roller.unused
  end

  private

  def roll_size(n)
    @roller.roll(n)
    @roller.faces.size
  end

  def assert_tween(min, max, actual, name)
    assert actual >= min, "#{name} must be >= #{min} (was #{actual})"
    assert actual <= max, "#{name} must be <= #{max} (was #{actual})"
  end

  def collect_face_counts
    result = Hash.new { |h, k| h[k] = 0 }
    1200.times do
      @roller.roll(5)
      @roller.faces.each do |face|
        result[face] += 1
      end
    end
    result
  end
end
