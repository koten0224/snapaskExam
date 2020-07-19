class TransactionRecord < ApplicationRecord
  belongs_to :user
  belongs_to :purchased_tutorial
  has_one :tutorial, through: :purchased_tutorial

  validate :tutorial_available?
  validate :expired?
  
  before_create :bill_information

  private

    def tutorial_available?
      unless tutorial.available?
        errors[:tutorial] << "not available."
      end
    end

    def expired?
      unless purchased_tutorial.expired?
        errors[:tutorial] << "has not expired yet."
      end
    end

    def bill_information
      self.price = tutorial.price
      self.currency = tutorial.currency
      self.expiration = tutorial.expiration
    end

end
