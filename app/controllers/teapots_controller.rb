class TeapotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_teapot, only: [:new, :create, :edit, :update, :destroy]

  def index
    teapots = Teapot.where(in_stock: true)
    @most_popular = teapots.sort_by { |teapot| teapot.views }.reverse.take(6)

    if params[:q].present?
      teapots = Teapot.search(params[:q])
    end

    @pagy, @teapots = pagy(teapots, items: 24)
  end

  def show
    @teapot = Teapot.find(params[:id])
  end

  def new
    @teapot = Teapot.new
    authorize @teapot
  end

  def create
    @teapot = Teapot.new(teapot_params)
    authorize @teapot
  end

  def edit
    @teapot = Teapot.find(params[:id])
    authorize @teapot
  end

  def update
    @teapot = Teapot.find(params[:id])
    authorize @teapot
  end

  def destroy
    @teapot = Teapot.find(params[:id])
    authorize @teapot
  end

  private

  def authorize_teapot
    authorize @teapot || Teapot
  end

  def teapot_params
    params.require(:teapot).permit(:height, :width, :depth, :weight, :ccs, :comment, :price_cents, :kilntype, :shape, :maker, :views, :in_stock, :sku, images: [])
  end
end
