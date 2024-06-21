class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :teapot, null: false, foreign_key: true
      t.timestamps
    end
  end
end
