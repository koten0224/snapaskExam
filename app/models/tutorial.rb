class Tutorial < ApplicationRecord
  belongs_to :user
  
  enum catagory: {
    "lalala" => 0,
    "yoyoyo" => 1,
    "hohoho" => 2
  }

  enum price_type: CURRENCIES.map

  has_many :purchased_tutorials
  has_many :transaction_records
  
end
