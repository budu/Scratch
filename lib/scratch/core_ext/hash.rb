
Hash.class_eval do

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
