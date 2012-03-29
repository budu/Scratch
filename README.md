# Scratch

After seeing a presentation (by [Gary Haran]) on Rails engines and
reading a [certain blog post], I decided that enough was enough! I had
some Rails induced itches that needed some much needed relief. Thus here
is Scratch, a library which tries to fix a bunch of Rails' most
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

### Mixins (or Concerns if you prefer the Rails vocabulary)

These mixins are included in ActiveRecord with this gem, they could
(theoretically) be used inside any other classes, but this hasn't been
tested (nor documented) yet.

#### Normalize

The `normalize` method help you create callbacks to normalize some
attributes in a simple declarative manner.

Say you'd like to set all blank attributes to nil before validation, you
could do:

```ruby
normalize before: :validation, when: :blank?, set: nil
```

The `before` option default to `:validation` so it can be omitted in
that case. You can also pass a block to `normalize` that will be given
the value of the attribute and should return it's normalized form:

```ruby
normalize { |value| value.strip }
```

The block in that example is a common pattern that can be replaced by
the `method` option:

```ruby
normalize method: :strip
```

There's two specialized mixins which are variant of the above
examples...

##### Stripify

The `stripify` method will strip all attributes, it also support all of
normalize options. Here's an example using the `except` option:

```ruby
stripify except: :foo
```

##### Nilify

Don't like odd numbers, here's a solution:

```ruby
nilify only: [:foo, :bar], when: :odd?, before: :save
```

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
