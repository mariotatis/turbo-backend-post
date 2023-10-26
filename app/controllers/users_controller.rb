class UsersController < ApplicationController
  include AuthenticationHelper

  def profile
    @user = current_user
  end

  def settings
    @user = current_user
  end
end