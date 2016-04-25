# return an anonymous class
class Factory
  
  def self.new(*method_names, &blok)
  	
  	# raise an ArgumentError if not given at least one argument
    raise ArgumentError, "wrong number of arguments (0 for 1+)" if method_names.empty?
    
    # raise a TypeError for arguments which are not symbols
    method_names.each do |x|
      raise TypeError unless x.kind_of? Symbol
    end
    
    Class.new do
      # methods defined by the factory
      include Enumerable

      define_method :initialize do |*args|
      	@args = Hash[method_names.zip args]
      end

      define_method "[]".to_sym do |x|
      	raise NameError, "no member '#{x}' in struct" unless @args.has_key? x.to_sym
      	@args[x.to_sym]
      end

      define_method "[]=".to_sym do |x, val|
      	raise NameError, "no member '#{x}' in struct" unless @args.has_key? x.to_sym
      	@args[x.to_sym] = val
      end

      define_method :inspect do
        a = @args.collect {|x,y| "#{x}=" + y.inspect}.join(", ")
        "#<struct #{a}>"
      end

      define_method :members do
        method_names
      end

      define_method :size do
      	@args.size
      end

      define_method :values do
      	@args.values
      end

      

    end

  end
end