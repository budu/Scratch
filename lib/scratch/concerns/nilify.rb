
module Scratch::Concerns::Nilify

  extend ActiveSupport::Concern

  module ClassMethods
    def nilify(options = {})
      options = HashWithIndifferentAccess.new options

      options[:before] ||= :validation
      options[:when]   ||= :blank?
      options[:name]   ||=
        "nilify_before_#{options[:before]}_when_#{options[:when]}"

      instance_eval do
        normalize options.merge(set: nil)
      end
    end
  end

end
