
Hash.class_eval do

  def fetch_or(*keys)
    options = keys.extract_options!

    keys.each do |key|
      begin
        return fetch(key)
      rescue
        next
      end
    end

    return options[:default] if options[:default]
    raise KeyError, ("keys not found: %s" % keys.inspect)
  end

  def invert_splat
    reduce({}) do |memo, (k, vs)|
      if vs.respond_to? :each
        vs.each { |v| memo[v] = k }
      else
        memo[vs] = k
      end
      memo
    end
  end

end
