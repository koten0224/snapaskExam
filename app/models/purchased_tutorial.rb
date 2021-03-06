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
  scope :category, ->(category_id) { where("tutorials.category_id = ?", category_id.to_i)}
  scope :available, ->(bool) { where("purchased_tutorials.deadline > ? is #{bool == "true"}", Time.now) }

  validate :tutorial_available?

  before_create :give_deadline

  def expired?
    deadline < Time.now
  end

  private

    def tutorial_available?
      unless tutorial.available?
        errors[:tutorial] << "not available."
      end
    end

    def give_deadline
      self.deadline = Time.now
    end

end
