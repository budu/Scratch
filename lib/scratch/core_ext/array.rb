
Array.class_eval do

  def strip_join(sep = $,)
    map { |item| item.to_s.strip }
      .reject(&:empty?)
      .join sep
  end

end
