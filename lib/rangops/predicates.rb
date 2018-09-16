module Rangops
  module Predicates

    unless Range.respond_to?(:overlaps?)
      # Taken from ActiveSupport - it's not in dependencies,
      # and the method itself is too useful to be left out.
      def overlaps?(other)
        cover?(other.first) || other.cover?(first)
      end
    end

  end
end

