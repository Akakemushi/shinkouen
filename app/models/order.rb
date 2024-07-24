class Order < ApplicationRecord
  monetize :amount_cents
  belongs_to :user
  has_many :order_items, dependent: :destroy
end
