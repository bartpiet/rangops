module Rangops
  module Predicates

    unless Range.respond_to?(:overlaps?)
      # Taken from ActiveSupport - it's not in dependencies,
      # and the method itself is too useful to be left out.
      def overlaps?(other)
        cover?(other.first) || other.cover?(first)
      end
    end

    def superset?(other)
      cover?(other.begin) && cover?(other.end)
    end
    alias_method :contains?, :superset?

    def proper_superset?(other)
      superset?(other) && self != other
    end

    def subset?(other)
      other.superset?(self)
    end
    alias_method :is_contained_by?, :subset?

    def proper_subset?(other)
      subset?(other) && self != other
    end

  end
end

