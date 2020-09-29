class TransactionService
  def show_duration
    t0 = Time.now
    yield
    t1= Time.now
    puts "duration : #{(t1-t0)*1000}" 
  end


## Les coherence



  def self.with_external_service

  end
end