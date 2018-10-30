class ApplicationController < ActionController::Base
    ########  All steps below this are to add 'is_caterer' to the user  ########
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:is_caterer])
      devise_parameter_sanitizer.permit(:account_update, keys: [:is_caterer])
    end
    ############  End all first_name and last_name  ##############################
end
