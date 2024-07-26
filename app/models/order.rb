class Order < ApplicationRecord
  enum status: {
    pending: 0,
    paid: 1
  }
  monetize :amount_cents
  belongs_to :user
  has_many :order_items, dependent: :destroy
end
