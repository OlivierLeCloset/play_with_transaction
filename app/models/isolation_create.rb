class IsolationCreate < TransactionService
    def session_1_no_transaction
      prd1 = Product.create!(
        name: SecureRandom.hex(10),
        brand: SecureRandom.hex(10),
        stock_count: 0
      )
      puts Product.count
      sleep 20
    end

    def session_1_with_transaction
      ActiveRecord::Base.transaction do 
        prd1 = Product.create!(
          name: SecureRandom.hex(10),
          brand: SecureRandom.hex(10),
          stock_count: 0
        )
        puts Product.count
        sleep 20
      end
    end

    def session_2
      puts Product.count
    end
end