#!/usr/bin/env ruby

require_relative '../../test_helper.rb'

class Scratch::Concerns::StripifyTest < Test::Unit::TestCase

  def setup
    @entity = StripifyTestModel.new foo: ' ', bar: ' '
  end

  def teardown
    @entity.delete
  end

  def test_callbacks_methods_are_defined
    assert @entity.respond_to? :stripify_before_validation
  end

  def test_effect_of_triggering_validation_callback
    @entity.valid?
    assert_equal ' ' , @entity.foo
    assert_equal ''  , @entity.bar
  end

end
