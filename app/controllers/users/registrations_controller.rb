# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  ######### FOR STORING PREVIOUS LOCATION ########
  # before_action :store_user_location!, if: :storable_location?
  

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  ################# ADD IS_CATERER TO SIGN ON SHEET ###############
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:is_caterer, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:is_caterer, :first_name, :last_name])
  end
  ################## END ######################

  ############## LOGIC TO SEND CATERER TO NEXT FORM AND CUSTOMER TO HOME PAGE #############
  ############## FUTURE FIX WILL BE TO SEND USER BACK TO PREVIOUS PAGE ##########
  def after_sign_up_path_for(resource)
    super(resource)
    ### FOR SOME REASON, IT IS COMING THROUGH AS STRING AND NOT AS BOOLEAN! ####
    if params[:user][:is_caterer] == "true"
      new_caterer_information_path
    else
      event_types_path
    end
  end

  # ############ Store last location, to send user back after they sign in ##############
  # private 

  # def storable_location?
  #   request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  # end

  # def store_user_location!
  #   # :user is the scope we are authenticating
  #   store_location_for(:user, request.fullpath)
  # end
  # ############ End store location ##############
  ######### END ############

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
