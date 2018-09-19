require "test_helper"

require "bundler/setup"
require "rangops"

class Range
  include Rangops::Set
end


class RangopsTest < Minitest::Test


  def setup

  end

  def test_union
    assert_equal (1..5).union(3..10), (1..10)
    assert_equal (3..10).union(1..5), (1..10)
    assert_equal (1..5).union(3...10), (1...10)

    assert_equal ('a'..'j').union('g'..'m'), ('a'..'m')
    assert_equal ('g'..'z').union('c'..'k'), ('c'..'z')
  end

  def test_intersection
    assert_equal (1..5).intersection(3..10), (3..5)
  end

  def test_complement
    assert_equal (1..5).complement(3..10), (5..10)
  end

  def test_difference
    assert_equal (1..5).difference(3..10), [(1..3), (5..10)]
  end

end
