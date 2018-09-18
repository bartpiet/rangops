# Rangops

Rangops is a simple Ruby extension library that aims to treat Ranges as sets.

It provides methods for elementary set related operations and predicates.

Union:

        (1..5).union(3..10)
        => 1..10

Same operation, more conveniently aliased:

        (1..5) | (3..10)
        => 1..10

Intersection:

        (1..5).intersection(3..10)
        => 3..5

        (1..5) & (3..10)
        => 3..5


Complement, difference operations and subset/superset checking is also available.
For full list of methods, check API docs.

No mapping of ranges to arrays is performed, so operations on ranges of any size
are possible without penalty on speed or memory usage. Ranges delimited with any
numerical values can be operated on.

        (1.0..10).union(Rational(20, 4)..Float::INFINITY)
        => 1.0..Infinity 

It works equally well on string and date ranges, although some operations may be
not available if they only make sense for numbers.

Library tries to adhere to conventions established in Ruby core and standard
library. It only focuses on extending core Range class; only ranges or elements
covered by them can be used as arguments. Due to the properties of Range class,
most operations return meaningful results only for ranges of the same type.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
