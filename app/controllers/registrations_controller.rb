class RegistrationsController < Devise::SessionsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: resource, status: :ok
    else
      render json: { errors: resource.errors }, status: :unprocessable_entity
    end
  end

  protected

  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end