module Menu
  def display_menu
    title("MENU")
  
    Product.all.each do |product|
      menu_line(product)
    end
  end

  private

  def tab_pad(label, tab_stop = 6)
    binding.pry
    label + "\t" * (tab_stop - (label.length / 8))
  end

  def clear_scr
    system "clear"
  end

  def title(title)
    length  = 80 - title.length
    padding = length / 2
    line = "-" * padding + title + "-" * padding
    puts line.length < 80 ? line + "-" : line
  end

  def line
    puts "-" * 80
  end

  def blank_line
    puts "\n"
  end

  def menu_line(product)
    printf " %-60s %s\n", "#{product.id}. #{product.name}", "$ #{sprintf("%02.2f", product.price)}"
  end
  
  def product_line (product, quantity)
    printf "  - %-57s %s\n", "#{quantity} x #{product.name}", "$ #{sprintf("%02.2f", product.price * quantity)}"
  end

  def summary_line(label, value)
    printf " %-60s %s\n", label, value
  end
end