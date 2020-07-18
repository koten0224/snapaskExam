class Tutorial < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum currency: CURRENCIES.map

  has_many :purchased_tutorials
  has_many :transaction_records

  validates :title, presence: true
  validates :currency, presence: true
  validates :price, numericality: { only_integer: true }
  validates :expiration, numericality: {
    only_integer: true,
    greater_than: 0,
    less_than: 31
  }

  def display_category
    category.name
  end
  
end
