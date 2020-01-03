class Api::V1::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    @items = ItemSerializer.new(current_user.items).serializable_hash
    render json: @items, status: :ok
  end

  def show
    render json: ItemSerializer.new(@item).serializable_hash, status: :ok
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      render json: ItemSerializer.new(@item).serializable_hash, status: :created
    else
      render json: { errors: @item.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      render json: ItemSerializer.new(@item).serializable_hash, status: :ok
    else
      render json: { errors: @item.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    head 204
  end

  private

  def item_params
    params.require(:item).permit(:name, :loan_date, :return_date, :contact_id, :photo)
  end

  def set_item
    @item = current_user.items.find(params[:id])
  end
end
