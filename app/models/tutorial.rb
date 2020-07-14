class Tutorial < ApplicationRecord
  belongs_to :user
  
  enum catagory: {
    "lalala" => 0,
    "yoyoyo" => 1,
    "hohoho" => 2
  }

  enum price_type: {
    "TWD" => 0,
    "USD" => 1
  }

  has_many :purchased_tutorials
  has_many :transaction_records
  
end
