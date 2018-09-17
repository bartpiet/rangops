module Rangops

  # Module defining basic set operations that can be performed
  # on ranges.
  #
  # * union
  # * intersection
  # * relative complement
  # * symmetric difference
  # along with some convenient aliases.
  # 
  # Operations involving 2 ranges require them to overlap to produce result.
  # If the result of operation cannot be expressed as single range,
  # an array of ranges is returned.
  module Operators

    # Set union of 2 ranges.  Returns nil if ranges don't overlap.
    def union(other)
      validate_operand(other)
      return nil unless overlaps?(other)

      lower, upper = Utils.sort_by_end(self, other)
      new_begin = [self.begin, other.begin].min
      Range.new(new_begin, upper.end, upper.exclude_end?)
    end
    alias_method :|, :union

    # Set intersection of 2 ranges.  Returns nil if ranges don't overlap.
    def intersection(other)
      validate_operand(other)
      return nil unless overlaps?(other)

      lower, upper = Utils.sort_by_end(self, other)
      new_begin = [self.begin, other.begin].max
      Range.new(new_begin, lower.end, lower.exclude_end?)
    end
    alias_method :&, :intersection

    # Relative complement of 2 ranges.
    def complement(other)
      validate_operand(other)
      return nil unless overlaps?(other)

      lower, upper = Utils.sort_by_end(self, other)
      new_begin = [self.end, other.end].min
      Range.new(new_begin, upper.end, upper.exclude_end?)
    end

    # Symmetric difference of 2 ranges.
    def difference(other)
      validate_operand(other)
      return nil unless overlaps?(other)

      lower, upper = Utils.sort_by_end(self, other)
      [Range.new(lower.begin, upper.begin),
      Range.new(lower.end, upper.end, upper.exclude_end?)]
    end

    private
      def validate_operand(other)
        unless other.is_a?(Range)
          raise ArgumentError, "expected a Range, got #{other.class} instead"
        end
      end

  end
end
