class Api::V1::ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :update, :destroy]

  def index
    render json: current_user.contacts, status: :ok
  end

  def show
    render json: @contact, status: :ok
  end

  def create
    @contact = current_user.contacts.build(contact_params)

    if @contact.save
      render json: @contact, status: :created
    else
      render json: { errors: @contact.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render json: @contact, status: :ok
    else
      render json: { errors: @contact.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    head 204
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :phone, :email)
  end

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

end
