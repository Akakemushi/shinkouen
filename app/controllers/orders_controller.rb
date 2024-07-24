class OrdersController < ApplicationController
  def create
    teapot = Teapot.find(params[:teapot_id])
    order  = Order.create!(teapot: teapot, teapot_sku: teapot.sku, amount: teapot.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      metadata: {
        teapot_id: teapot.id
      },
      customer_email: current_user.email,
      line_items: [{
        quantity: 1,
        price_data: {
          currency: 'jpy',
          unit_amount: teapot.price_cents,
          product_data: {
            name: "Purchacing teapot by #{teapot.maker}",
          }
        }
      }],
      mode: 'payment',
      success_url: order_url(order),
      cancel_url: teapot_url(teapot)
    )

    redirect_to session.url, allow_other_host: true, status: 303
    #   payment_method_types: ['card'],
    #   line_items: [{
    #     name: teapot.sku,
    #     images: [teapot.images.first.key],
    #     amount: teapot.price_cents,
    #     currency: 'jpy',
    #     quantity: 1
    #   }],
    #   success_url: order_url(order),
    #   cancel_url: order_url(order)
    # )

    # order.update(checkout_session_id: session.id)
    # redirect_to new_order_payment_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
