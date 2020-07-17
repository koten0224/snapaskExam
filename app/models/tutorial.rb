class Tutorial < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum currency: CURRENCIES.map

  has_many :purchased_tutorials
  has_many :transaction_records

  def display_category
    category.name
  end
  
end
