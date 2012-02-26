
module Scratch::Concerns::Nilify

  extend ActiveSupport::Concern

  module ClassMethods
    def self.extended(base)
      base.cattr_accessor :nilify_attributes_source
      base.nilify_attributes_source =
        if base == ActiveRecord::Base
          -> base { base.content_columns.map(&:name) }
        end
    end

    def nilify(options = {})
      options = HashWithIndifferentAccess.new options

      pred       = options[:pred]   || :blank?
      before     = options[:before] || :validation
      callback   = "nilify_before_#{before}_if_#{pred}"
      attributes = Scratch::Options
        .except_only options, nilify_attributes_source[self]

      instance_eval do
        define_method callback do
          attributes.each do |attribute|
            value = send(attribute)
            send("#{attribute}=", nil) if value.send(pred)
          end
        end

        send "before_#{before}", callback
      end
    end
  end

end

ActiveRecord::Base.send :include, Scratch::Concerns::Nilify
