class CreateTeapots < ActiveRecord::Migration[7.1]
  def change
    create_table :teapots do |t|
      t.string :image
      t.float :height
      t.float :width
      t.float :depth
      t.float :weight
      t.integer :ccs
      t.text :comment
      t.integer :price, null: false
      t.string :type, null: false
      t.string :maker, null: false
      t.boolean :in_stock, null: false, default: true
      t.timestamps
    end
  end
end
