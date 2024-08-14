class AddStripeCheckoutIdColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :state, :string
    remove_column :orders, :checkout_session_id, :string
    add_column :orders, :session_id, :string
    add_column :orders, :stripe_checkout_id, :string
    add_column :orders, :status, :integer, default: 0
  end
end
