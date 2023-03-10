# frozen_string_literal: true

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
      { product:, quantity: }
    end
  end

  def sub_total
    contents.map do |line_item|
      product = line_item[:product]
      (product.price + Tax.calculate(product)) * line_item[:quantity]
    end.inject(:+)
  end

  def order_tax
    contents.map do |line_item|
      product = line_item[:product]
      Tax.calculate(product) * line_item[:quantity]
    end.inject(:+)
  end

  def display(type = :order)
    title(" #{type.to_s.capitalize} ")
    contents.each do |line_item|
      product = line_item[:product]
      product_line(product, line_item[:quantity])
    end

    line
    summary_line('Subtotal:', "$ #{format('%.2f', sub_total)}")
  end

  def receipt
    display(:receipt)
    summary_line('Sales Taxes:', "$ #{format('%.2f', order_tax)}")
    line
    summary_line('Total:', "$ #{format('%.2f', sub_total + order_tax)}")
    line
  end
end
