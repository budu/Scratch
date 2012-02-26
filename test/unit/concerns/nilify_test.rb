#!/usr/bin/env ruby

require_relative '../../test_helper.rb'

class Scratch::Concerns::NilifyTest < Test::Unit::TestCase

  def setup
    @entity = NilifyTestModel.new foo: '', bar: '', baz: 1
  end

  def teardown
    @entity.delete
  end

  def test_callbacks_methods_are_defined
    assert @entity.respond_to? :nilify_before_validation_if_blank?
    assert @entity.respond_to? :nilify_before_save_if_odd?
  end

  def test_effect_of_triggering_validation_callback
    @entity.valid?
    assert_equal ''  , @entity.foo
    assert_equal nil , @entity.bar
    assert_equal 1   , @entity.baz
  end

  def test_effect_of_triggering_save_callback
    @entity.save
    assert_equal ''  , @entity.foo
    assert_equal nil , @entity.bar
    assert_equal nil , @entity.baz
  end

end
