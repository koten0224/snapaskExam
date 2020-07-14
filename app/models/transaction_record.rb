class TransactionRecord < ApplicationRecord
  belongs_to :user
  belongs_to :purchased_tutorial
end
