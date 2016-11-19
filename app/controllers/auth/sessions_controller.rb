class Auth::SessionsController < Devise::SessionsController
  before_action :set_offline, only: [:destroy]
  layout 'simple'
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || dashboard_path
  end

  def set_offline
    current_user.update_column :availability, 'offline'
  end
end
