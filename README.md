# Rangops

Rangops is a tiny Ruby extension library that aims to treat Ranges as sets.

FIXME: __Install it with `gem install rangops` or add `gem "rangops"` to your Gemfile.__

It patches `Range` class with methods for basic set related operations
and predicates, like:

Union:

    (1..5).union(3..10)
    => 1..10

    (1..5) + (3..10)
    => 1..10

Intersection:

    (1..5).intersection(3..10)
    => 3..5

    (1..5) & (3..10)
    => 3..5


Symmetric difference:

    (1..10).difference(5..15)
    => [1..5, 10..15]

    (1..10) - (5..15)
    => [1..5, 10..15]

Relative complement:

    (1..10).complement(5..15)
    => 10..15


Check [API docs](https://bartpiet.github.io/rangops/) for full list of aliases
and predicates.

There is no mapping to arrays nor iteratons under the hood,
just begin/end values comparison - so operations on ranges of any size are
possible, with no penalty on speed or memory usage.
Ranges delimited with any type of Numerics can be used.

    (1.0..10).union(Rational(20, 4)..Float::INFINITY)
    => 1.0..Infinity 

Beginless and endless ranges are supported.

    (nil..10).intersection(5..nil)
    => 5..10

    (nil..10).union(5..nil)
    => nil..nil

It works well on string and date ranges too.

    ('2025-01-01'..'2026-12-31') & ('2026-01-01'..'2027-12-31')
    => '2026-01-01'..'2026-12-31'

    ('a'..'e') & ('c'..'g')
    => "c".."e"


Operations are supposed to return a `Range` result, so they only work on 
arguments delimited with values of the same type.
`(1..5) & ('c'..'g')` will just return `nil`


## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
