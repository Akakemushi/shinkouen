class TeapotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @teapot = Teapot.new
    authorize @teapot
  end

  def create
    @teapot = Teapot.new(teapot_params)
    authorize @teapot
    # ...
  end

  def edit
    @teapot = Teapot.find(params[:id])
    authorize @teapot
  end

  def update
    @teapot = Teapot.find(params[:id])
    authorize @teapot
    # ...
  end

  def destroy
    @teapot = Teapot.find(params[:id])
    authorize @teapot
    # ...
  end
end
