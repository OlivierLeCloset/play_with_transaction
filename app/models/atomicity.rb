class Atomicity < TransactionService
  def initialize
    Product.delete_all
  end

  def no_transactions_no_raise
    puts "Trying to create two products >  #{Product.count} "
    result = {}
    begin
      prd1 = Product.create(
        name: SecureRandom.hex(10),
        brand: SecureRandom.hex(10),
        stock_count: 0
      )

      prd2 = Product.create(
        name: SecureRandom.hex(10),
        brand: SecureRandom.hex(10),
#          stock_count: 0
      )
      result = {prd1: prd1, prd2: prd2}
    rescue
    ensure
      puts "So Far everything is fine ! #{Product.count} ¿? :-("
      result 
    end
  end

  def no_transactions_with_raise
    puts "Trying to create two products >  #{Product.count} "
    result = {}
    begin
      prd1 = Product.create!(
        name: SecureRandom.hex(10),
        brand: SecureRandom.hex(10),
        stock_count: 0
      )

      prd2 = Product.create!(
        name: SecureRandom.hex(10),
        brand: SecureRandom.hex(10),
        # stock_count: 0
      )
                  
      result = {prd1: prd1, prd2: prd2}
    rescue
    ensure
      puts "So Far everything is fine ! #{Product.count} ¿? :-("
      result
    end
  end

  def with_transactions_no_raise
    puts "Trying to create two products #{Product.count}"
    result = {}
    begin
      ActiveRecord::Base.transaction do 
        prd1 = Product.create(
          name: SecureRandom.hex(10),
          brand: SecureRandom.hex(10),
          stock_count: 0
         )

        prd2 = Product.create(
          name: SecureRandom.hex(10),
          brand: SecureRandom.hex(10),
          #stock_count: 0
        )
        result = {prd1: prd1, prd2: prd2}
      end
    rescue
    ensure
      puts "So Far everything is fine ! #{Product.count} ¿? :-("
      result
    end
  end

  def with_transactions_with_raise
    puts "Trying to create two products #{Product.count}"
    result = {}
    begin
      ActiveRecord::Base.transaction do 
        prd1 = Product.create!(
          name: SecureRandom.hex(10),
          brand: SecureRandom.hex(10),
          stock_count: 0
        )

        prd2 = Product.create!(
          name: SecureRandom.hex(10),
          brand: SecureRandom.hex(10),
          #stock_count: 0
          )
        result = {prd1: prd1, prd2: prd2}
      end
      
    rescue
    ensure
      puts "So Far everything is fine ! #{Product.count} ¿? :-("
      result
    end
  end
end
