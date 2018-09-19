module Rangops

  # Module defining basic set operations that can be performed
  # on ranges.
  #
  # * union
  # * intersection
  # * relative complement
  # * symmetric difference
  #
  # along with some convenient aliases.
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
    #     (1..10) | (5..15) # using pipe operator
    #     => 1..15
    def union(other)
      validate_operand(other)
      return nil unless overlaps?(other)

      lower, upper = Utils.sort_by_end(self, other)
      new_begin = [self.begin, other.begin].min
      Range.new(new_begin, upper.end, upper.exclude_end?)
    end
    alias_method :|, :union

    # Intersection of 2 ranges. Returns a range covering elements
    # common to both ranges. Returns `nil` if ranges don't overlap.
    #
    #     (1..10).intersection(5..15)
    #     => 5..10
    #     (1..10) & (5..15) # using ampersand operator
    #     => 5..10
    def intersection(other)
      validate_operand(other)
      return nil unless overlaps?(other)

      lower, upper = Utils.sort_by_end(self, other)
      new_begin = [self.begin, other.begin].max
      Range.new(new_begin, lower.end, lower.exclude_end?)
    end
    alias_method :&, :intersection

    # Relative complement of 2 ranges. Returns a range covering
    # elements from `other` that are not covered by `self`.
    # Returns `nil` if ranges don't overlap.
    #
    #     (1..10).complement(5..15)
    #     => 10..15
    def complement(other)
      validate_operand(other)
      return nil unless overlaps?(other)

      lower, upper = Utils.sort_by_end(self, other)
      new_begin = [self.end, other.end].min
      Range.new(new_begin, upper.end, upper.exclude_end?)
    end

    # Symmetric difference of 2 ranges. Returns ranges covering
    # elements of both operands, excluding elements common for both
    # of them. Returns `nil` if ranges don't overlap.
    #
    #     (1..10).difference(5..15)
    #     => [1..5, 10..15]
    def difference(other)
      validate_operand(other)
      return nil unless overlaps?(other)

      lower, upper = Utils.sort_by_end(self, other)
      [Range.new(lower.begin, upper.begin),
      Range.new(lower.end, upper.end, upper.exclude_end?)]
    end


    unless Range.respond_to?(:overlaps?)
      # Taken from ActiveSupport - it's not in dependencies,
      # and the method itself is too useful to be left out.
      def overlaps?(other)
        cover?(other.first) || other.cover?(first)
      end
    end

    # Checks if `self` is superset of `other`.
    def superset?(other)
      cover?(other.begin) && cover?(other.end)
    end
    alias_method :contains?, :superset?

    # Checks if `self` is proper superset of `other`,
    # i.e. is superset and has elements not present
    # in `other`.
    def proper_superset?(other)
      superset?(other) && self != other
    end

    # Checks if `self` is subset of `other`.
    def subset?(other)
      other.superset?(self)
    end
    alias_method :is_contained_by?, :subset?

    # Checks if `self` is proper subset of `other`,
    # i.e. is subset and has elements not present
    # in `other`.
    def proper_subset?(other)
      subset?(other) && self != other
    end


    private
      def validate_operand(other)
        unless other.is_a?(Range)
          raise ArgumentError, "expected a Range, got #{other.class} instead"
        end
      end

  end
end