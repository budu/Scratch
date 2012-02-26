
module Scratch::Concerns::Stripify

  extend ActiveSupport::Concern

  included do
    cattr_accessor :stripify_attributes_source
    self.stripify_attributes_source =
      if self == ActiveRecord::Base
        -> base { base.content_columns.map(&:name) }
      end
  end

  module ClassMethods
    def stripify(options = {})
      options = HashWithIndifferentAccess.new options

      before     = options[:before] || :validation
      callback   = "stripify_before_#{before}"
      attributes = Scratch::Options
        .except_only options, stripify_attributes_source[self]

      instance_eval do
        define_method callback do
          attributes.each do |attribute|
            value = send(attribute)
            send("#{attribute}=", value.strip) if value.is_a? String
          end
        end

        send "before_#{before}", callback
      end
    end
  end

end
