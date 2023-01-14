class Order
  def initialize
    @products = Hash.new(0)
    @tax = 0
  end
  
  def add_product(product_id, quantity = 1)
    @products[product_id] += quantity
  end

  def remove_product(product_id, quantity = 1)
    @products[product_id] -= quantity
  end

  def empty?
    @products.empty?
  end
  
  def contents
    @products.map do |product_id, quantity|
      product = Product.find(product_id)
      { product: product, quantity: quantity }
    end
  end

  def sub_total
    contents.map do |line_item|
      product = line_item[:product]
      product.price * line_item[:quantity]
    end.inject(:+)
  end

  def order_tax
    contents.map do |line_item|
      product = line_item[:product]
      Tax.calculate(product) * line_item[:quantity]
    end.inject(:+)
  end

  def display(type = :order)
    line
    puts "#{type.to_s.capitalize}: "
    contents.each do |line_item|
      product = line_item[:product]
      puts " - #{tab_pad("#{product.name}")}#{line_item[:quantity]} x $ #{product.price}"
    end

    line
    puts "Subtotal:                                  $ #{sub_total}"
  end

  def receipt
    display(:receipt)
    puts "Sales Taxes:                               $ #{order_tax}"
    line
    puts "Total:                                     $ #{sub_total + order_tax}"
  end
end