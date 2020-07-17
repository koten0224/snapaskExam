class Tutorial < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum price_type: CURRENCIES.map

  has_many :purchased_tutorials
  has_many :transaction_records
  
end
