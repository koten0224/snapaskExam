class PurchasedTutorial < ApplicationRecord
  belongs_to :user
  belongs_to :tutorial
  has_many :transaction_records
  has_one :category, through: :tutorial

  validate :tutorial_available?

  before_create :give_deadline

  def available?
    deadline > Time.now
  end

  private

    def tutorial_available?
      unless tutorial.available?
        errors[:tutorial] << "not allow to purchase."
      end
    end

    def give_deadline
      self.deadline = Time.now
    end

end
