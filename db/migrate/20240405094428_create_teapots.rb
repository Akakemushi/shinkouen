class CreateTeapots < ActiveRecord::Migration[7.1]
  def change
    create_table :teapots do |t|
      t.float :height
      t.float :width
      t.float :depth
      t.float :weight
      t.integer :ccs
      t.text :comment
      t.integer :price, null: false
      t.string :kilntype, null: false
      t.string :shape, null: false
      t.string :maker, null: false
      t.integer :views, null: false, default: 0
      t.boolean :in_stock, null: false, default: true
      t.timestamps
    end
  end
end
