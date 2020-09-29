class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string "name"
      t.string "brand"
      t.integer "stock_count"
      t.timestamps
    end
  end
end
