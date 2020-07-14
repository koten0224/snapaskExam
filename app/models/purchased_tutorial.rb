class PurchasedTutorial < ApplicationRecord
  belongs_to :user
  belongs_to :tutorial
  has_many :transaction_records
end
