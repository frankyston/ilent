class Api::V1::ContactsController < ApplicationController
  include Paginable
  before_action :authenticate_user!
  before_action :set_options
  before_action :set_contact, only: [:show, :update, :destroy]

  def index
    @contacts = current_user.contacts.page(current_page).per(per_page)
    @options = get_links_serializer_options(@options, 'api_v1_contacts_path', @contacts)
    @contacts = ContactSerializer.new(@contacts, @options).serializable_hash
    render json: @contacts, status: :ok
  end

  def show
    render json: ContactSerializer.new(@contact).serializable_hash, status: :ok
  end

  def create
    @contact = current_user.contacts.build(contact_params)

    if @contact.save
      render json: ContactSerializer.new(@contact).serializable_hash, status: :created
    else
      render json: { errors: @contact.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render json: ContactSerializer.new(@contact).serializable_hash, status: :ok
    else
      render json: { errors: @contact.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    head 204
  end

  private

  def set_options
    @options = { include: [:user] }
  end

  def contact_params
    params.require(:contact).permit(:name, :phone, :email)
  end

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

end
