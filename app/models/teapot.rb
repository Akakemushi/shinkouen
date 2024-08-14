require 'money'
class Teapot < ApplicationRecord
  has_many_attached :images
  monetize :price_cents
  has_one :cart_item, dependent: :destroy
  has_one :order_item, dependent: :destroy

  validates :sku, presence: true, uniqueness: true
  validates :maker, presence: true
  validates :price_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :kilntype, presence: true
  validates :shape, presence: true
  # validates :height, :width, :depth, :weight, :ccs, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # uncomment line above if dimensions need to be made mandatory for some reason.

  def formatted_price
    Money.new(self.price, "JPY").format
  end

end
