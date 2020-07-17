class PurchasedTutorial < ApplicationRecord
  belongs_to :user
  belongs_to :tutorial
  has_many :transaction_records
  has_one :category, through: :tutorial
end
