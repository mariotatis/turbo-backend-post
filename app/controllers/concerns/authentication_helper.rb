module AuthenticationHelper
    extend ActiveSupport::Concern
  
    included do
      before_action :auth_user
    end
  
    def auth_user
      unless user_signed_in?
        redirect_to home_path
      end
    end
end