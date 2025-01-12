# class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

#   skip_before_action :verify_authenticity_token, only: :keycloakopenid

#   def keycloakopenid
#     logger.debug("OJO! keycloakopenid params(#{params.inspect})")
#     logger.debug("OJO! keycloakopenid request.env[omniauth.auth](#{request.env["omniauth.auth"]})")

#     @user = User.from_omniauth(request.env["omniauth.auth"])

#     if @user.persisted?
#       sign_in_and_redirect @user, event: :authentication
#     else
#       flash[:error] = 'Error when trying to login with Keycloak, please try again.'
#       session["devise.keycloakopenid_data"] = request.env["omniauth.auth"]
#       redirect_to new_user_registration_url
#     end
#   end

#   def failure
#     logger.debug("OJO! failure  params(#{params.inspect})")
#     logger.debug("OJO! failure request.env[omniauth.auth](#{request.env["omniauth.auth"]})")
#     flash[:error] = "Error when trying to login with Keycloak, please try again. (#{params.inspect}) (#{request.env["omniauth.auth"]})"
#     redirect_to root_path
#   end  
# end

