class CreateTeapots < ActiveRecord::Migration[7.1]
  def change
    create_table :teapots do |t|
      t.integer :height
      t.integer :width
      t.integer :depth
      t.integer :weight
      t.integer :ccs
      t.text :comment
      t.integer :price_cents, default: 0, null: false
      t.string :kilntype, null: false
      t.string :shape, null: false
      t.string :maker, null: false
      t.integer :views, null: false, default: 0
      t.boolean :in_stock, null: false, default: true
      t.string :sku, null: false
      t.timestamps
    end
  end
end
