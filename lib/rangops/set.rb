module Rangops

  # Module defining basic set operations that can be performed
  # on ranges.
  #
  # * union
  # * intersection
  # * relative complement
  # * symmetric difference
  #
  # along with some convenient aliases and predicates.
  # Loosely follows conventions of `Set` module from standard library.
  #
  # Operations involving 2 ranges require them to overlap to produce result.
  # If the result of operation cannot be expressed as single range,
  # an array of ranges is returned.
  module Set

    # Union of 2 ranges. Returns a range covering sum of all elements
    # belonging to both ranges. Returns `nil` if ranges don't overlap.
    #
    #     (1..10).union(5..15)
    #     => 1..15
    #     (5..10) | (9..24)
    #     => 5..24
    #     (1...10) + (10..30)
    #     => nil
    def union(other)
      validate_args(self, other)
      return nil unless intersect?(other)

      lower, upper = Set.sort_by_boundaries(self, other)
      Range.new(lower.begin, upper.end, upper.exclude_end?)
    end
    alias_method :|, :union
    alias_method :+, :union

    # Intersection of 2 ranges. Returns a range covering elements
    # common to both ranges. Returns `nil` if ranges don't overlap.
    #
    #     (1..10).intersection(5..15)
    #     => 5..10
    #
    #     (5..10) & (9..24)
    #     => 9..10
    def intersection(other)
      validate_args(self, other)
      return nil unless intersect?(other)

      lower, upper = Set.sort_by_boundaries(self, other)
      Range.new(upper.begin, lower.end, lower.exclude_end?)
    end
    alias_method :&, :intersection

    # Relative complement of 2 ranges. Returns a range covering
    # elements from `other` that are not covered by `self`.
    # Returns `nil` if ranges don't overlap.
    #
    #     (1..10).complement(5..15)
    #     => 10..15
    def complement(other)
      validate_args(self, other)
      return nil unless intersect?(other)

      _, upper = Set.sort_by_boundaries(self, other)
      new_begin = [self.end, other.end].compact.min
      Range.new(new_begin, upper.end, upper.exclude_end?)
    end

    # Symmetric difference of 2 ranges. Returns ranges covering
    # elements of both operands, excluding elements common for both
    # of them. Returns `nil` if ranges don't overlap.
    #
    #     (1..10).difference(5..15)
    #     => [1..5, 10..15]
    #
    #     (11..19) - (15..28)
    #     => [11..15, 19..28]
    def difference(other)
      validate_args(self, other)
      return nil unless intersect?(other)

      lower, upper = Set.sort_by_boundaries(self, other)
      [Range.new(lower.begin, upper.begin),
      Range.new(lower.end, upper.end, upper.exclude_end?)]
    end
    alias_method :-, :difference


    # Checks if 2 ranges have any common elements.
    #
    #      (1..10).intersect?(8..15)
    #      => true
    #
    #      (1..10).intersect?(11..15)
    #      => false
    def intersect?(other)
      lower, upper = Set.sort_by_boundaries(self, other)
      lower.cover?(upper.begin) || upper.cover?(lower.end)
    end


    # Opposite of `intersect?.
    def disjoint?(other)
      !intersect?(other)
    end

    # Checks if `self` is superset of `other`, i.e. all
    # elements of `other` fit within `self`.
    #
    #     (1..10).superset?(2..5)
    #     => true
    #
    #     (1..10).superset?(1..10)
    #     => true
    #
    #     (1..10).superset?(5..12)
    #     => false
    def superset?(other)
      cover?(other.begin) && cover?(other.end)
    end
    alias_method :contains?, :superset?

    # Checks if `self` is proper superset of `other`,
    # i.e. is superset and has elements not present
    # in `other`.
    #
    #     (1..10).proper_superset?(2..5)
    #     => true
    #
    #     (1..10).proper_superset?(1..10)
    #     => false
    def proper_superset?(other)
      superset?(other) && self != other
    end

    # Checks if `self` is subset of `other`, i.e. all
    # elements of `self` fit within `other`.
    #
    #     (1..10).subset?(0..12)
    #     => true
    #
    #     (1..10).subset?(1..10)
    #     => true
    #
    #     (1..10).subset?(5..12)
    #     => false
    def subset?(other)
      other.superset?(self)
    end
    alias_method :is_contained_by?, :subset?

    # Checks if `self` is proper subset of `other`,
    # i.e. is subset and has elements not present
    # in `other`.
    #
    #     (1..10).proper_subset?(0..12)
    #     => true
    #
    #     (1..10).proper_subset?(1..10)
    #     => false
    def proper_subset?(other)
      subset?(other) && self != other
    end

    private

    def validate_args(*args)
      args.reject{ |a| a.is_a?(Range) }.each do |arg|
        raise ArgumentError, "expected a Range, got #{other.class} instead"
      end
    end

    # Determine which range has lower begin, and which one higher end.
    def self.sort_by_boundaries(a, b)
      ary = [a, b]
      lower = ary.find{ |r| r.begin.nil? } || ary.sort_by(&:begin).first
      upper = ary.find{ |r| r.end.nil? }   || ary.sort_by(&:end).last
      [lower, upper]
    end

  end
end
