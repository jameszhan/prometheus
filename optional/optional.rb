class Optional

  def initialize(value)
    @value =  value
  end

  def method_missing(method, *args, &block)
    if @value != nil
      @value.send method, *args, &block
    else
      if method.to_s =~ /^.+!$/
        nil
      else
        Optional.new(nil)
      end
    end
  end

end