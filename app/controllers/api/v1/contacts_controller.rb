class Api::V1::ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.contacts, status: :ok
  end

end
