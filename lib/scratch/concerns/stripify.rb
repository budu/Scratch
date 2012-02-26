
module Scratch::Concerns::Stripify

  extend ActiveSupport::Concern

  module ClassMethods
    def stripify(options = {})
      options = HashWithIndifferentAccess.new options

      options[:before] ||= :validation
      options[:name]   ||= "stripify_before_#{options[:before]}"

      instance_eval do
        normalize options.merge(method: :strip)
      end
    end
  end

end
