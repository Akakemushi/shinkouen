class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = current_user.cart
    @cart_items = current_user.cart.cart_items.includes(:teapot)
  end

  def create
    @teapot = Teapot.find(params[:teapot_id])
    @cart = current_user.cart

    if @cart.teapots.include?(@teapot)
      respond_to do |format|
        format.html { redirect_to @teapot, notice: "This teapot is already in your cart." }
        format.json { render json: { message: "This teapot is already in your cart." }, status: :unprocessable_entity }
      end
    else
      @cart_item = @cart.cart_items.build(teapot: @teapot)

      if @cart_item.save
        respond_to do |format|
          format.html { redirect_to @teapot, notice: "Teapot successfully added to your cart." }
          format.json { render json: { message: "Teapot successfully added to your cart.", cart_item_id: @cart_item.id }, status: :created }
        end
      else
        respond_to do |format|
          format.html { redirect_to @teapot, alert: "Failed to add teapot to your cart." }
          format.json { render json: { message: "Failed to add teapot to your cart." }, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @cart_item = current_user.cart.cart_items.find(params[:id])

    if @cart_item
      @cart_item.destroy
      respond_to do |format|
        format.html { redirect_to teapot_path(params[:teapot_id]), notice: "Teapot removed from your cart." }
        format.json { render json: { message: "Teapot removed from your cart." }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to teapot_path(params[:teapot_id]), alert: "Teapot not found in your cart." }
        format.json { render json: { message: "Teapot not found in your cart." }, status: :not_found }
      end
    end
  end

  def total_price
    begin
      if current_user.cart && current_user.cart.cart_items
        total_price_cents = current_user.cart.cart_items.joins(:teapot).sum('teapots.price_cents')
        formatted_price = Money.new(total_price_cents, "JPY").format
        render json: { total_price: formatted_price }
      else
        render json: { error: "Cart or cart items not found" }, status: :internal_server_error
      end
    rescue => e
      Rails.logger.error "Error calculating total price: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      render json: { error: "Error calculating total price" }, status: :internal_server_error
    end
  end
end
