
module Scratch::Options

  def self.except_only(options, source)
    %w(except only).each do |key|
      options[key] = Array.wrap(options[key]).map &:to_s if options[key]
    end

    (options[:only] || source) - (options[:except] || [])
  end

end
