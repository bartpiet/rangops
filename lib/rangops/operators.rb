module Rangops
  module Operators

    def union(other)
      unless other.is_a? Range
        raise ArgumentError, "expected a Range, got #{other.class} instead"
      end
      unless (cover?(other.first) || other.cover?(first))
        raise ArgumentError, "non overlapping ranges"
      end
      b, e = [self.begin, other.begin].min, [self.end, other.end].max
      b..e
    end

  end
end
