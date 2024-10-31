class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create] # Evita el error CSRF en el callback

  def create
    logger.debug("OJO! keycloakopenid params(#{params.inspect})")
    logger.debug("OJO! keycloakopenid request.env[omniauth.auth](#{request.env["omniauth.auth"]})")

    auth = request.env['omniauth.auth']
    # Aquí puedes manejar el usuario, crear uno nuevo en tu base de datos, etc.
    session[:user_id] = auth['info']['email']  # Guarda el ID de usuario o el email en la sesión
    redirect_to root_path, notice: 'Successfully signed in!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end

  def failure
    redirect_to root_path, alert: 'Authentication failed!'
  end
end