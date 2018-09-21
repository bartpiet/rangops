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
      Rangops::Set.union(self, other)
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
      Rangops::Set.intersection(self, other)
    end
    alias_method :&, :intersection

    # Relative complement of 2 ranges. Returns a range covering
    # elements from `other` that are not covered by `self`.
    # Returns `nil` if ranges don't overlap.
    #
    #     (1..10).complement(5..15)
    #     => 10..15
    def complement(other)
      Rangops::Set.complement(self, other)
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
      Rangops::Set.difference(self, other)
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
      Rangops::Set.intersect(self, other)
    end


    # Opposite of `intersect?. 
    def disjoint?(other)
      Rangops::Set.disjoint?(self, other)
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
      Rangops::Set.superset?(self, other)
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
      Rangops::Set.proper_superset?(self, other)
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
      Rangops::Set.subset?(self, other)
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
      Rangops::Set.proper_subset?(self, other)
    end

  end
end
