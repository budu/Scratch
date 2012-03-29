#!/usr/bin/env ruby

require_relative '../../test_helper.rb'

class Scratch::Concerns::NormalizeTest < Test::Unit::TestCase

  def setup
    @entity = NormalizeTestModel.new foo: '', bar: 1, baz: '!'
  end

  def teardown
    @entity.delete
  end

  def test_must_specify_a_trigger_for_normalize
    assert_raise ArgumentError do
      NormalizeTestModel.class_eval { normalize }
    end
  end

  def test_must_specify_an_action_for_normalize
    assert_raise ArgumentError do
      NormalizeTestModel.class_eval { normalize trigger: :foo }
    end
  end

  def test_callbacks_methods_are_defined
    assert_respond_to @entity, :normalize_after_save
  end

  def test_effect_of_triggering_validation_callback
    @entity.valid?
    assert_equal '',  @entity.foo
    assert_equal 0 ,  @entity.bar
    assert_equal '!', @entity.baz
  end

  def test_effect_of_triggering_save_callback
    @entity.save
    assert_equal 'foo', @entity.foo
    assert_equal 0    , @entity.bar
    assert_equal '!!',  @entity.baz
  end

end
