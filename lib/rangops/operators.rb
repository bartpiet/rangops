module Rangops
  module Operators

    # Set union of 2 ranges.  Returns nil if ranges don't overlap.
    def union(other)
      unless other.is_a?(Range)
        raise ArgumentError, "expected a Range, got #{other.class} instead"
      end
      return nil unless overlaps?(other)

      lower, upper = Utils.sort_by_end(self, other)
      new_begin = [self.begin, other.begin].min
      Range.new(new_begin, upper.end, upper.exclude_end?)
    end
    alias_method :|, :union

    # Set intersection of 2 ranges.  Returns nil if ranges don't overlap.
    def intersection(other)
      unless other.is_a?(Range)
        raise ArgumentError, "expected a Range, got #{other.class} instead"
      end
      return nil unless overlaps?(other)

      lower, upper = Utils.sort_by_end(self, other)
      new_begin = [self.begin, other.begin].max
      Range.new(new_begin, lower.end, lower.exclude_end?)
    end
    alias_method :&, :intersection

  end
end
