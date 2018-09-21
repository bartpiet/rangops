module Rangops
  module Set

    def self.union(a, b)
      validate_args(a,b)
      return nil unless intersect?(a, b)

      lower, upper = Utils.sort_by_end(a, b)
      new_begin = [a.begin, b.begin].min
      Range.new(new_begin, upper.end, upper.exclude_end?)
    end

    def self.intersection(a, b)
      validate_args(a, b)
      return nil unless intersect?(a, b)

      lower, upper = Utils.sort_by_end(a, b)
      new_begin = [a.begin, b.begin].max
      Range.new(new_begin, lower.end, lower.exclude_end?)
    end

    def self.complement(a, b)
      validate_args(a, b)
      return nil unless intersect?(a, b)

      lower, upper = Utils.sort_by_end(a, b)
      new_begin = [a.end, b.end].min
      Range.new(new_begin, upper.end, upper.exclude_end?)
    end

    def self.difference(a, b)
      validate_args(a, b)
      return nil unless intersect?(a, b)

      lower, upper = Utils.sort_by_end(a, b)
      [Range.new(lower.begin, upper.begin),
      Range.new(lower.end, upper.end, upper.exclude_end?)]
    end

    def self.intersect?(a, b)
      a.cover?(b.begin) || b.cover?(a.begin)
    end

    def self.disjoint?(a, b)
      !intersect?(a, b)
    end

    def self.superset?(a, b)
      a.cover?(b.begin) && a.cover?(b.end)
    end

    def self.proper_superset?(a, b)
      a.superset?(b) && a != b
    end

    def self.subset?(a, b)
      b.superset?(a)
    end

    def self.proper_subset?(a, b)
      a.subset?(b) && a != b
    end

    private
      def self.validate_args(*args)
        args.reject{ |a| a.is_a?(Range) }.each do |arg|
          raise ArgumentError, "expected a Range, got #{other.class} instead"
        end
      end
    
  end
end

