class CreatePurchasedTutorials < ActiveRecord::Migration[5.2]
  def change
    create_table :purchased_tutorials do |t|
      t.references :user, foreign_key: true
      t.references :tutorial, foreign_key: true
      t.datetime :deadline

      t.timestamps
    end
  end
end
