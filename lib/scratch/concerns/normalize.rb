require 'scratch/utils'

# == Normalize Callbacks
#
# The <tt>normalize</tt> callback helpers let you define callbacks that
# normalize data on a set of attributes.
#
module Scratch::Concerns::Normalize

  extend ActiveSupport::Concern

  included do
    cattr_accessor :normalize_default_attributes_source
    self.normalize_default_attributes_source =
      if self == ActiveRecord::Base
        -> base { base.content_columns.map(&:name) }
      end
  end

  module ClassMethods
    def normalize(options = {})
      callback_options = HashWithIndifferentAccess.new options

      options   = callback_options.slice!(:if, :unless)
      set       = options[:set]
      method    = options[:method]
      predicate = Array.wrap options[:when]

      trigger_format = options[:trigger_format] || '%s_%s'

      trigger = options[:trigger] ||
        (options[:before] ? trigger_format % [:before , options[:before]] :
         options[:after]  ? trigger_format % [:after  , options[:after]]  :
         raise(ArgumentError, 'missing option, you must specify one of: ' +
               'before, after or trigger'))

      unless options.has_key?(:set) || method || block_given?
        raise(ArgumentError, 'missing option or block, ' +
              'you must give a block or specify one of: set or method')
      end

      callback = options[:name] || Scratch::Utils.gensym

      attributes = options[:attributes] ||
        Scratch::Options
          .except_only(options, normalize_default_attributes_source[self])

      instance_eval do
        define_method callback do
          attributes.each do |attribute|
            value = send(attribute)
            if predicate.empty? || value.send(*predicate)
              value =
                if options.has_key? :set
                  set
                elsif method
                  value.send method
                else
                  yield value
                end

              send "#{attribute}=", value
            end
          end
        end
      end

      send trigger, callback
    end
  end

end
