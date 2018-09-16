module Rangops
  module Utils

    # Sort ranges by their end value, respecting possible exclusions.
    def self.sort_by_end(*ranges)
      ranges.sort_by do |r|
        [r.end, r.exclude_end? ? 0 : 1]
      end
    end

  end
end
