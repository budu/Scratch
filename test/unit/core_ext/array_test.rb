#!/usr/bin/env ruby

require_relative '../../test_helper.rb'

class CoreExt::ArrayTest < Test::Unit::TestCase

  def setup
    @sep = $,
    $, = ', '
  end

  def teardown
    $, = @sep
  end

  def test_strip_join_ignore_nils
    assert_equal '2, 3', [nil, 2, 3].strip_join
    assert_equal '1, 3', [1, nil, 3].strip_join
    assert_equal '1, 2', [1, 2, nil].strip_join
  end

  def test_strip_join_ignore_empty_strings
    assert_equal '2, 3', ['', 2, 3].strip_join
    assert_equal '1, 3', [1, '', 3].strip_join
    assert_equal '1, 2', [1, 2, ''].strip_join
  end

  def test_strip_join_strip_strings
    assert_equal 'foo', ['  foo  '].strip_join
  end

  def test_strip_join_behave_as_join
    a = (1..1000000).to_a
    assert_equal a.join, a.strip_join
  end

end
