require 'csv'
require 'pry'
require_relative '../lib/display_elemets'
require_relative '../lib/product'
require_relative '../lib/order'
require_relative '../lib/tax'

include DisplayElemets

class App
  def initialize
    @order = Order.new
  end

  def current_order
    @order
  end

  def self.start
    new.start
  end

  def print_receipt
    clear_scr
    current_order.receipt
  end

  def start
    while true
      clear_scr

      title(' SALES TAX CALCULATOR ')
      blank_line
      puts "  Enter product id and quantity to add to order. Enter 'x' to print receipt."
      blank_line
      display_menu

      current_order.display unless current_order.empty?

      line
      blank_line
      print 'Product ID: '
      product_id = gets.chomp
      break if product_id == 'x'

      print 'Quantity: '
      quantity = gets.chomp
      break if quantity == 'x'

      current_order.add_product(product_id, quantity.to_i)
    end

    print_receipt
  end
end

App.start
