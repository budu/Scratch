
module Scratch::Concerns::Nilify

  extend ActiveSupport::Concern

  module ClassMethods
    def nilify(options = {})
      options = HashWithIndifferentAccess.new options

      options[:before]    ||= :validation
      options[:predicate] ||= :blank?
      options[:name]      ||=
        "nilify_before_#{options[:before]}_if_#{options[:predicate]}"

      instance_eval do
        normalize options.merge(default: nil)
      end
    end
  end

end
