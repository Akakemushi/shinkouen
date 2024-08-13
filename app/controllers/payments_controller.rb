class PaymentsController < ApplicationController
  def new
    @order = current_user.orders.where(state: 'pending').find(params[:order_id])
  end

  def show
    @order = Order.find_by(stripe_checkout_id: params[:session_id])
    stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])
    if stripe_session.status == "complete"
      @order.paid!
      @order.order_items.each do |order_item|
        teapot = order_item.teapot.reload
        teapot.update!(in_stock: false)
      end

      #other business logic, sending emails, etc
    else
      @order.pending!
      #means the user has come to this page but maybe something has been delayed, or some other issue has occured.
    end
  end
end
