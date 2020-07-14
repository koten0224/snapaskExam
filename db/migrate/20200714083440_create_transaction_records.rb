class CreateTransactionRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_records do |t|
      t.references :user, foreign_key: true
      t.references :purchased_tutorial, foreign_key: true
      t.integer :price
      t.integer :price_type
      t.integer :expiration

      t.timestamps
    end
  end
end
