class CreateTutorials < ActiveRecord::Migration[5.2]
  def change
    create_table :tutorials do |t|
      t.references :user
      t.string :title
      t.integer :price
      t.integer :price_type
      t.integer :catagory
      t.boolean :available
      t.string :url
      t.string :desc
      t.integer :expiration

      t.timestamps
    end
  end
end
