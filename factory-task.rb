require './factory.rb'

Customer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end
p Customer.new("Dave", "123 Main").greeting