require 'money'
class Teapot < ApplicationRecord
  has_many_attached :images

  def formatted_price
    Money.new(self.price, "JPY").format
  end
end
