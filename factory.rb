class Factory
  
  def self.new(*method_names, &blok)
  	
    # raise an ArgumentError if not given at least one argument
    raise ArgumentError, "wrong number of arguments (0 for 1+)" if method_names.empty?
    
    method_names.each do |x|
      raise TypeError unless x.kind_of? Symbol
    end
    
    Class.new do
      
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

      def each(&blok)
        @args.values.each &blok
      end

      def select(&blok)
        values.select &blok
      end

      method_names.each_with_index do |x, y|
        getter = x.to_sym
        setter = "#{x}=".to_sym

        define_method getter do
          @args[getter]
        end
        define_method setter do |value|
          @args[getter] = value
        end
      end

      alias :length :size
      alias :to_s  :inspect
      alias :to_a :values

      class_eval &blok if blok

    end

  end
end