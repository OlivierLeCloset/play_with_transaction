class Deadlock < TransactionService
  def self.prepare
    Product.create!(
      name: SecureRandom.hex(10),
      brand: SecureRandom.hex(10),
      stock_count: 0
    )
    Product.create!(
      name: SecureRandom.hex(10),
      brand: SecureRandom.hex(10),
      stock_count: 0
    )
  end

  def product1 
    Product.first
  end

  def product2
    Product.second
  end

  def session1
    ActiveRecord::Base.transaction do
      product1.lock!
      product1.update(stock_count: product2.stock_count)

      product2.lock!
      product2.update(stock_count: product1.stock_count)
      sleep 10
    end
  end

  def session2
    ActiveRecord::Base.transaction do
      product2.lock!
      product2.update(stock_count: product1.stock_count)
      product1.lock!
      product1.update(stock_count: product2.stock_count)
      sleep 10
    end
  end
end
