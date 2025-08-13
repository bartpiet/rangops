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

    assert_equal (3..nil).union(1..5), (1..nil)
    assert_equal (nil..6).union(1..9), (nil..9)
    assert_equal (nil..nil).union(1..5), (nil..nil)

    assert_equal ('a'..'j').union('g'..'m'), ('a'..'m')
    assert_equal ('g'..'z').union('c'..'k'), ('c'..'z')

    assert_equal ('g'..nil).union('c'..'k'), ('c'..nil)
  end

  def test_intersection
    assert_equal (1..5).intersection(3..10), (3..5)
    assert_equal (1..5).intersection(3..nil), (3..5)
    assert_equal (nil..5).intersection(3..10), (3..5)
    assert_equal (nil..5).intersection(3..nil), (3..5)
    assert_nil   (1...5).intersection(5..10)
  end

  def test_complement
    assert_equal (1..5).complement(3..10), (5..10)
    assert_equal (1..5).complement(3..nil), (5..nil)
  end

  def test_difference
    assert_equal (1..5).difference(3..10), [(1..3), (5..10)]
    assert_equal (1..5).difference(3..nil), [(1..3), (5..nil)]
    assert_equal (nil..5).difference(3..10), [(nil..3), (5..10)]
  end

  def test_intersect
    assert (1..5).intersect?(3..10)
    assert (1..5).intersect?(3..nil)
    assert (nil..5).intersect?(3..10)
    assert (nil..5).intersect?(3..nil)
    assert (1..5).intersect?(5..10)

    assert (1..5).disjoint?(7..10)
    assert (1..5).disjoint?(6..10)
    assert (1..5).disjoint?(7..nil)

    refute (1...5).intersect?(5..10)
  end

  def test_superset
    assert (1..5).superset?(3..4)
    assert (1..nil).superset?(3..4)

    assert (1..5).superset?(1..5)
    refute (1..5).proper_subset?(1..5)

    refute (1...5).superset?(1..5)
    assert (1..5).superset?(1...5)
    refute (1..5).proper_superset?(1..5)
  end

end
