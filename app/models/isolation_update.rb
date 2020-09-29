class IsolationUpdate < TransactionService
  attr_reader :product

  def initialize
    if Product.count == 0
      Product.create!(
        name: SecureRandom.hex(10),
        brand: SecureRandom.hex(10),
        stock_count: 0
      )
    end

  end

  def product
    @product ||= Product.first
  end

  def stock_count
    @stock_count ||= (rand*1000).round
  end

  def session_1_no_transaction
      puts stock_count
      product.stock_count = stock_count
      product.save

      sleep 20
  end

  def session_1_with_transaction
    ActiveRecord::Base.transaction do 
      puts stock_count
      product.stock_count = stock_count
      product.save
      sleep 20
    end

  end

  def session_2_with_transaction
    ActiveRecord::Base.transaction do 
      puts stock_count
      product.stock_count = stock_count
      product.save
      sleep 20
    end
  end

  def session_3_check
    puts product.reload.stock_count
  end

end