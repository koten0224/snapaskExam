class CreateCategories < ActiveRecord::Migration[5.2]

  def up
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end
    remove_column :tutorials, :catagory
    add_reference :tutorials, :category, foreign_key: true
    rename_column :tutorials, :price_type, :currency
    rename_column :transaction_records, :price_type, :currency
    ['Front-end', 'Back-end', 'DevOps', 'Git', 'Internet'].each do |text|
      Category.create(name: text)
    end
    Tutorial.all.each do |tutorial|
      tutorial.category_id = rand(1..5)
      tutorial.save
    end

  end

  def down
    rename_column :tutorials, :currency, :price_type
    rename_column :transaction_records, :currency, :price_type
    remove_column :tutorials, :category_id
    add_column :tutorials, :catagory, :integer
    drop_table :categories
  end

end
