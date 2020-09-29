class NestedTransaction < Transaction
  def initialize
    Product.delete_all
  end

  def nested_transaction_failed
    puts "Trying to create two products #{Product.count}"
    result = {}
    begin
      prd1 = nil
      prd2 = nil
      ActiveRecord::Base.transaction do
        prd1 = Product.create!(
          name: SecureRandom.hex(10),
          brand: SecureRandom.hex(10),
          stock_count: 0
        )

        ActiveRecord::Base.transaction do
          prd2 = Product.create!(
            name: SecureRandom.hex(10),
            brand: SecureRandom.hex(10),
            #stock_count: 0
          )
        end
        result = {prd1: prd1, prd2: prd2}
      end

    rescue
    ensure
      puts "So Far everything is fine ! #{Product.count} ¿? :-("
      result
    end
  end

  def parent_transaction_failed
    puts "Trying to create two products #{Product.count}"
    result = {}
    begin
      prd1 = nil
      prd2 = nil
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.transaction do
          prd1 = Product.create!(
            name: SecureRandom.hex(10),
            brand: SecureRandom.hex(10),
            stock_count: 0
          )
        end
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

  def nested_transaction_rollback
    puts "Trying to create two products #{Product.count}"
    result = {}
    begin
      prd1 = nil
      prd2 = nil
      ActiveRecord::Base.transaction do
        prd1 = Product.create!(
          name: SecureRandom.hex(10),
          brand: SecureRandom.hex(10),
          stock_count: 0
        )

        ActiveRecord::Base.transaction do
          prd2 = Product.create!(
            name: SecureRandom.hex(10),
            brand: SecureRandom.hex(10),
            stock_count: 0
          )
          raise ActiveRecord::Rollback
        end
        result = {prd1: prd1, prd2: prd2}
      end
      
    rescue
    ensure
      puts "So Far everything is fine ! #{Product.count} ¿? :-("
      result
    end
  end


end
