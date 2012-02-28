# Scratch

After seeing a presentation (by [Gary Haran]) on Rails engines and
reading a [certain blog post], I decided that enough was enough! I had
some Rails induced itches that needed some much needed relief. Thus here
is Scratch, a library which tries to fix a bunch of relatively
insignificant shortcomings.

## Features

 * The normalize model mixin
 * A few core extensions

## Installation

Simply add Scratch to your Gemfile and bundle it up:

```ruby
gem 'scratch'
```

## Usage

### Core Extensions

#### Array

Want to use `join` for user facing stuff but doesn't want to clean up
the array yourself, use `strip_join`:

```ruby
[1, 2, nil, '', '    ' , '   3  '].strip_join ', '
#=> "1, 2, 3"
```

#### Hash

Have many keys to look-up and need the first one available, use `fetch_or`:

```ruby
h = { a: 1, b: 2, c: 3 }
h.fetch_or :e, :d, :c
#=> 3
# also support a `default` option...
h.fetch_or :x, :y, :z, default: nil
#=> nil
# when no default is given, act like `fetch` and raise a `KeyError`
```

You're stuck with a hash having arrays as values and need to invert it?

```ruby
h = { west_coast: %w(WA OR CA AZ), east_east: %w(ME VT NY NJ) }
y = h.invert_splat
y['NJ']
#=> :east_coast
```

## License

This project rocks and uses MIT-LICENSE!

[Gary Haran]: https://github.com/garyharan
[certain blog post]: http://gilesbowkett.blogspot.in/2012/02/rails-went-off-rails-why-im-rebuilding.html
