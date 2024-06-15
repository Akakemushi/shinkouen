class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :state
      t.string :teapot_sku
      t.string :checkout_session_id
      t.integer :amount_cents, default: 0, null: false
      t.references :user, null: false, foreign_key: true
      t.references :teapot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
