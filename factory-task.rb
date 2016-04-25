require './factory.rb'

# from RubyGarage slide
Customer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end
p Customer.new("Dave", "123 Main").greeting