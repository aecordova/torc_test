class Tax
  TAX_RATE = 0.1
  IMPORT_TAX_RATE = 0.05
  EXEMPT_CATEGORIES = %w[books food medical]

  def self.calculate(product)
    tax = 0.0
    tax += product.price * TAX_RATE unless exempt?(product.category)
    tax += product.price * IMPORT_TAX_RATE if product.imported?
    tax
  end

  def self.exempt?(category)
    EXEMPT_CATEGORIES.include?(category)
  end

  private_class_method :exempt?
end
