require 'money'
class Teapot < ApplicationRecord
  has_many_attached :images
  monetize :price_cents

  def formatted_price
    Money.new(self.price, "JPY").format
  end

end
