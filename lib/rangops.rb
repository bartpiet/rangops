require "rangops/version"
require "rangops/operators"
require "rangops/predicates"
require "rangops/utils"

module Rangops

  include Predicates
  include Operators


  # Sort ranges by their end value, respecting possible exclusions.
  def self.sort_by_end(*ranges)
    ranges.sort_by do |r|
      [r.end, r.exclude_end? ? 0 : 1]
    end
  end

end
