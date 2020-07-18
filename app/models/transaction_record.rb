class TransactionRecord < ApplicationRecord
  belongs_to :user
  belongs_to :purchased_tutorial
  has_one :tutorial, through: :purchased_tutorial
  validate :can_buy?
  before_create :bill_information

  private

    def can_buy?
      unless tutorial.available?
        errors[:tutorial] << "not allow to purchase."
      end
      if purchased_tutorial.available?
        errors[:tutorial] << "is still available."
      end
    end

    def bill_information
      self.price = tutorial.price
      self.currency = tutorial.currency
      self.expiration = tutorial.expiration
    end

end
