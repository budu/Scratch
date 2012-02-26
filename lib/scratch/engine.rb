module Scratch
  class Engine < ::Rails::Engine
    isolate_namespace Scratch

    initializer 'concerns.extend_active_record' do
      ActiveSupport.on_load :active_record do
        %w(Nilify Normalize Stripify).each do |mod|
          mod = "Scratch::Concerns::#{mod}".constantize
          ActiveRecord::Base.send :include, mod
        end
      end
    end
  end
end
