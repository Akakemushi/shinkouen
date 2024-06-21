class ChangePriceInTeapots < ActiveRecord::Migration[7.1]
  # def up
  #   rename_column :teapots, :price, :price_cents
  #   change_column :teapots, :price_cents, :integer, default: 0
  # end

  # def down
  #   change_column :teapots, :price_cents, :integer
  #   rename_column :teapots, :price_cents, :price
  # end
end
