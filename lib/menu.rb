module Menu
  def display_menu
    line
    puts "Menu: "
  
    Product.all.each do |product|
      puts "  #{tab_pad("#{product.id}. #{product.name}")}$ #{product.price}"
    end
  end

  private

  def tab_pad(label, tab_stop = 4)
    label_tabs = label.length / 8
    label.ljust(label.length + tab_stop - label_tabs, "\t")
  end

  def clear_scr
    system "clear"
  end

  def line
    puts "------------------------------------------------"
  end
end