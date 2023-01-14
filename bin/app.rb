require 'csv'
require 'pry'
require_relative '../lib/menu'
require_relative '../lib/product'
require_relative '../lib/order'
require_relative '../lib/tax'

include Menu

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
      display_menu

      current_order.display unless current_order.empty?

      puts "\nEnter product id and quantity to add to order. Enter 'x' to print receipt. \n"
      print "Product ID: "
      product_id = gets.chomp
      
      print "Quantity: "
      quantity = gets.chomp
      print_receipt if qproduct_id == 'x' || quantity == 'x'  
      break if product_id == 'x' || quantity == 'x'     
      clear_scr

      current_order.add_product(product_id, quantity.to_i)
    end
  end
end

App.start
