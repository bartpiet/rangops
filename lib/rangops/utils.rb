module Rangops
  module Utils

    # Determine which range has lower begin, and which one higher end.
    def self.sort_by_boundaries(a, b)
      ary = [a, b]
      lower = ary.find{ |r| r.begin.nil? } || ary.sort_by(&:begin).first
      upper = ary.find{ |r| r.end.nil? }   || ary.sort_by(&:end).last
      [lower, upper]
    end

  end
end
