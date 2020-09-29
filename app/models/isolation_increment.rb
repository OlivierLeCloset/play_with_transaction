class IsolationIncrement < TransactionService

  def initialize
    if Product.count == 0
      Product.create!(
        name: SecureRandom.hex(10),
        brand: SecureRandom.hex(10),
        stock_count: 0
      )
    else
      increment_start
    end
  end

  def product
    @product ||= Product.first
  end


  def increment_start
    product.stock_count = 0
    product.save
  end

  def increment_no_transaction
    show_duration {
      5000.times {
        product.reload
        product.stock_count += 1
        product.save
      }
    }
  end

  def increment_with_transaction
    show_duration {
      5000.times {
        ActiveRecord::Base.transaction do 
          product.reload
          product.stock_count += 1
          product.save
        end
      }
    }
  end

  def increment_with_lock
    show_duration {
      5000.times {
        ActiveRecord::Base.transaction do 
          product.lock!
          product.stock_count += 1
          product.save
        end
      }
    }
  end
  
  def increment_value
    product.reload.stock_count
  end

end
