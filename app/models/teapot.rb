require 'money'
class Teapot < ApplicationRecord
  has_many_attached :images
  monetize :price_cents
  has_one :cart_item, dependent: :destroy
  has_one :order_item, dependent: :destroy

  def formatted_price
    Money.new(self.price, "JPY").format
  end

end
