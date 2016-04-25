class Factory
  
  def self.new(*method_names, &blok)
  	
  	# raise an ArgumentError if not given at least one argument
    raise ArgumentError, "wrong number of arguments (0 for 1+)" if method_names.empty?
    
    # raise a TypeError for arguments which are not symbols
    method_names.each do |x|
      raise TypeError unless x.kind_of? Symbol
    end

  end
end