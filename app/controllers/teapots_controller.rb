class TeapotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_teapot, only: [:new, :create, :edit, :update, :destroy]

  def index
    teapots = Teapot.where(in_stock: true)

    @makers = Teapot.distinct.pluck(:maker)
    @styles = Teapot.distinct.pluck(:shape)
    @materials = Teapot.distinct.pluck(:kilntype)

    if params[:search_by].present?
      case params[:search_by]
      when 'price'
        condition = params[:price_condition] == 'less_than' ? '<=' : '>='
        teapots = teapots.where("price_cents #{condition} ?", params[:price].to_i)
      when 'maker'
        teapots = teapots.where(maker: params[:maker])
      when 'style'
        teapots = teapots.where(shape: params[:style])
      when 'material'
        teapots = teapots.where(kilntype: params[:material])
      when 'capacity'
        condition = params[:capacity_condition] == 'less_than' ? '<=' : '>='
        teapots = teapots.where("ccs #{condition} ?", params[:capacity].to_i)
      end
    end

    @most_popular = teapots.sort_by { |teapot| teapot.views }.reverse.take(6)
    @pagy, @teapots = pagy(teapots, items: 24)
  end

  def show
    @teapot = Teapot.find(params[:id])
    @teapot.increment!(:views)
  end

  def new
    @teapot = Teapot.new
    authorize @teapot
  end

  def create
    @teapot = Teapot.new(teapot_params)
    authorize @teapot

    if @teapot.save
      flash[:notice] = 'Teapot was successfully created.'
      redirect_to new_teapot_path
    else
      flash.now[:alert] = 'There was an error creating the teapot. Please check the form for errors.'
      Rails.logger.debug "Flash alert set: #{flash.now[:alert]}"
      render :new
    end
  end

  def edit
    @teapot = Teapot.find(params[:id])
    authorize @teapot
  end

  def update
    @teapot = Teapot.find(params[:id])
    authorize @teapot

    # Handle removal of selected images
    if params[:teapot][:remove_images].present?
      params[:teapot][:remove_images].each do |signed_id|
        attachment = @teapot.images.attachments.find { |att| att.signed_id == signed_id }
        if attachment
          Rails.logger.debug "Purging image with signed_id: #{signed_id}"
          attachment.purge
        else
          Rails.logger.debug "No image found with signed_id: #{signed_id}"
        end
      end
    end

    # Update the teapot with other attributes (excluding images)
    if @teapot.update(teapot_params.except(:images))
      # Attach new images if any
      if params[:teapot][:images].present?
        @teapot.images.attach(params[:teapot][:images])
      end

      flash[:notice] = 'Teapot was successfully updated.'
      redirect_to teapot_path(@teapot)
    else
      flash.now[:alert] = 'There was an error updating the teapot.'
      render :edit
    end
  end

  def destroy
    @teapot = Teapot.find(params[:id])
    authorize @teapot

    if @teapot.destroy
      flash[:notice] = 'Teapot was successfully deleted.'
    else
      flash[:alert] = 'There was an error deleting the teapot.'
    end

    respond_to do |format|
      format.html { redirect_to teapots_path }
      format.json { head :no_content }
    end
  end

  private

  def authorize_teapot
    authorize @teapot || Teapot
  end

  def teapot_params
    params.require(:teapot).permit(:height, :width, :depth, :weight, :ccs, :comment, :price_cents, :kilntype, :shape, :maker, :views, :in_stock, :sku, images: [])
  end
end
