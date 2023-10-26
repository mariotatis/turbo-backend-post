# frozen_string_literal: true

class Registrations::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    params[:user].merge!(remember_me: 1)
    super
  end


  #DELETE /resource/sign_out
  # def destroy
  #   puts '----------------------------------signed out----------------------------------'
  #   redirect_to home_path, notice: "You have successfully logged out...", turbolinks: false
  #   return
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end