require 'securerandom'

module Scratch::Utils

  def self.gensym
    ('_' + SecureRandom.uuid.gsub('-', '_')).to_sym
  end

end
