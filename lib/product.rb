class Product
  PRODUCTS_DB = "data/products.csv"

  attr_accessor :name, :price
  attr_reader :id, :category
  
  def initialize(id, name, price, category)
    @id = id
    @name = name
    @price = price.to_f
    @category = category
  end

  def imported?
    name.include?("imported")
  end

  def self.all
    @all ||= CSV.read(PRODUCTS_DB, headers: true).map do |row| 
      new(row["id"], row["name"], row["price"], row["category"])
    end
  end

  def self.find(id)
    all.find { |product| product.id == id }
  end
end