class PurchasedTutorial < ApplicationRecord
  belongs_to :user
  belongs_to :tutorial
  has_many :transaction_records
  has_one :category, through: :tutorial

  default_scope {
    joins(:tutorial)
    .includes(:tutorial)
    .includes(:transaction_records)
    .includes(:category)
  }
  scope :category, ->(category_id) { where("tutorials.category_id = ?", category_id)}
  scope :available, ->(bool) { where("purchased_tutorials.deadline > ? is #{bool}", Time.now) }

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
