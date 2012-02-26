#!/usr/bin/env ruby

require_relative '../../test_helper.rb'

class Scratch::CoreExt::HashTest < Test::Unit::TestCase

  def setup
    @h  = { a: [1, 2, 3], b: [4, 5] }
    @is = { 1 => :a, 2 => :a, 3 => :a, 4 => :b, 5 => :b }
  end

  def test_fetch_or
    assert_equal :a, @is.fetch_or(1)
    assert_equal :b, @is.fetch_or(7, 6, 5)
    assert_equal :c, @is.fetch_or(9, 8, default: :c)
    assert_raise(KeyError) { @is.fetch_or(10) }
  end

  def test_invert_splat
    assert_equal @is, @h.invert_splat
  end

  def test_invert_splat
    h  = @h.merge c: 6
    is = @is.merge 6 => :c
    assert_equal is, h.invert_splat
  end

end
