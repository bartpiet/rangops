# Rangops

Rangops is a simple Ruby extension library that aims to treat Ranges as sets.

It provides methods for elementary set related operations and predicates.

        class Range
          include Rangops::Set
        end

Union:

        (1..5).union(3..10)
        => 1..10

        (11..19) | (16..23)
        => 11..23

Intersection:

        (1..5).intersection(3..10)
        => 3..5

        (11..19) & (16..23)
        => 16..19


Complement, difference operations and subset/superset checking is also available.
For full list of methods, check [API docs](https://bartpiet.github.io/rangops/).

No mapping to arrays nor iterating on elements is performed, so operations
on ranges of any size are possible without penalty on speed or memory usage.
Ranges delimited with any type of Numerics can be operated.

        (1.0..10).union(Rational(20, 4)..Float::INFINITY)
        => 1.0..Infinity 

It works equally well on string and date ranges, although some operations may be
not available if they only make sense for numbers.

Library tries to adhere to conventions established in Ruby core and `Set` module
from standard library. It only focuses on extending core Range class; only ranges or
elements covered by them can be used as arguments. Due to the properties of Range class,
most operations return meaningful results only for ranges of the same type.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
