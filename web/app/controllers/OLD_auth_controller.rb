# class AuthController < ApplicationController
#   def keycloak_openid
#     # Manejar la respuesta de Keycloak aquí
#     logger.debug("OJO! keycloakopenid params(#{params.inspect})")
#     logger.debug("OJO! keycloakopenid request.env[omniauth.auth](#{request.env["omniauth.auth"]})")

#     auth = request.env['omniauth.auth']
#     # Aquí puedes manejar el usuario, crear uno nuevo en tu base de datos, etc.
#     if auth && auth['info'] && auth['info']['email']
#       session[:user_id] = auth['info']['email']  # Guarda el ID de usuario o el email en la sesión
#       redirect_to root_path, notice: 'Successfully signed in!'
#     else
#       flash[:error] = 'Error when trying to login with Keycloak, please try again.'
#       #session["devise.keycloakopenid_data"] = request.env["omniauth.auth"]
#       session[:user_id] = nil
#       redirect_to root_path
#     end

#     #@user = User.from_omniauth(request.env["omniauth.auth"])

#     #if @user.persisted?
#     #  sign_in_and_redirect @user, event: :authentication
#     #else
#     #   flash[:error] = 'Error when trying to login with Keycloak, please try again.'
#     #   session["devise.keycloakopenid_data"] = request.env["omniauth.auth"]
#     #   redirect_to new_user_registration_url
#     # end

#   end

#   # def failure
#   #   redirect_to root_path, alert: 'Authentication failed!'
#   # end
# end