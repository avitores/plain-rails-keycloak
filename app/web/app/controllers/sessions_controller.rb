class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create] # Evita el error CSRF en el callback

  def create_OLD
    auth = request.env['omniauth.auth']
    session[:user_emil] = auth['info']['email']
    redirect_to root_path, notice: 'Signed in!'    
  end

  def create
    authorization_code = params[:code]
    access_token = fech_token(authorization_code, "http://localhost:3011/callback")
    user_info = fetch_user_info(access_token, ENV['KEYCLOAK_URL'])

    logger.debug("OJO! create params[:code] (#{params[:code].inspect})")
    logger.debug("OJO! create authorization_code (#{authorization_code.inspect})")
    logger.debug("OJO! create access_token (#{access_token.inspect})")

    if authorization_code.blank?
      render plain: "Error: No se recibió el código de autorización", status: :bad_request
      return
    elsif access_token.blank?
      render plain: "Error: No se obtuvo acess_token", status: :bad_request
      return
    elsif user_info.blank?
      render plain: "Error: No se obtuvo informaciń del usuario", status: :bad_request
      return
    end
    #json_string = user_info.encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
    load_user_session(user_info)
    redirect_to root_path, notice: 'Successfully signed in!'
  end

  def init
    @authorization_code = params[:code]
    if @authorization_code.blank?
      render plain: "Error: No se recibió el código de autorización", status: :bad_request
      return
    end
  end

  def get_token
    @authorization_code = CGI.unescape(params[:authorization_code])
    @access_token = fech_token(@authorization_code, "http://localhost:3011/init")
  end

  def get_user_info
    @access_token = CGI.unescape(params[:access_token]).gsub('%2E','.')
    @user_info = fetch_user_info(@access_token, ENV['KEYCLOAK_URL'])
    json_string = @user_info.encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
    @email = JSON.parse(json_string)['email']
  end

  def init_session
    logger.debug("OJO! init_session params[:user_info]  (#{params[:user_info].inspect})")
    load_user_session(params[:user_info])
    #load_user_session(user_info)
    redirect_to root_path, notice: params[:email].blank? ? 'No hay email de usuario' : 'Successfully signed in!'
  end

  def fech_token(authorization_code, redirect_uri, keycloak_url = "http://keycloak_web:8080")
    uri = URI("#{keycloak_url}/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/token")

    request_body = {
      #grant_type: "client_credentials",
      grant_type: 'authorization_code',
      client_id: ENV['KEYCLOAK_CLIENT_ID'],
      client_secret: ENV['KEYCLOAK_CLIENT_SECRET'],
      redirect_uri: redirect_uri, # La misma URL que registraste en Keycloak
      scope: "openid email profile",
      code: authorization_code,
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https" # Habilitar SSL si la URL usa HTTPS
    request = Net::HTTP::Post.new(uri.path)
    request["Content-Type"] = "application/x-www-form-urlencoded"
    request.set_form_data(request_body)

    response = http.request(request)

    logger.debug("OJO! fech_token uri (#{uri.inspect})")
    logger.debug("OJO! fech_token request_body (#{request_body.inspect})")
    logger.debug("OJO! fech_token authorization_code (#{authorization_code.inspect})")
    logger.debug("OJO! fech_token keycloak_url (#{keycloak_url.inspect})")
    logger.debug("OJO! fech_token response (#{response.inspect})")
    logger.debug("OJO! fech_token response.code (#{response.code.inspect})") if response
    logger.debug("OJO! fech_token response.body (#{response.body.inspect})") if response
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)["access_token"]
    end
  end

  def fetch_user_info(access_token, keycloak_url = "http://keycloak_web:8080")
    url = URI("#{keycloak_url}/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/userinfo")

    http = Net::HTTP.new(url.host, url.port);
    http.use_ssl = (url.scheme == "https")

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{access_token}"
    request["User-Agent"] = "Rails/7.0.0"

    response = http.request(request)

    logger.debug("OJO! fetch_user_info access_token (#{access_token.inspect})")
    logger.debug("OJO! fetch_user_info keycloak_url (#{keycloak_url.inspect})")
    logger.debug("OJO! fetch_user_info response (#{response.inspect})")
    logger.debug("OJO! fetch_user_info response.code (#{response.code.inspect})") if response
    logger.debug("OJO! fetch_user_info response.body (#{response.body.inspect})") if response

    logger.debug("OJO! response(#{response.inspect})")
    
    if response && response.is_a?(Net::HTTPSuccess)
      response.read_body
    end
  end

  def load_user_session(user_info)
    email = JSON.parse(user_info)['email']
    given_name = JSON.parse(user_info)['given_name']
    family_name = JSON.parse(user_info)['family_name']

    logger.debug("OJO! load_user_session email  (#{email.inspect})")
    logger.debug("OJO! load_user_session given_name  (#{given_name.inspect})")
    logger.debug("OJO! load_user_session family_name  (#{family_name.inspect})")

    session[:user_email] = email if email
    session[:user_given_name] = given_name if given_name
    session[:user_family_name] = family_name if family_name
    
    logger.debug("OJO! load_user_session session[:user_email]  (#{session[:user_email].inspect})")
    logger.debug("OJO! load_user_session session[:user_given_name]  (#{session[:user_given_name].inspect})")
    logger.debug("OJO! load_user_session session[:user_family_name]  (#{session[:user_family_name].inspect})")
  end

  def destroy
    # Elimina la sesión de Rails
    logger.debug("OJO! destroy ANTES(#{session[:user_info].inspect})")
    reset_session
    logger.debug("OJO! destroy DESPUES(#{session[:user_info].inspect})")
    redirect_to root_path
    # Redirige al usuario a la URL de logout de Keycloak
    #redirect_to "#{ENV['KEYCLOAK_URL']}/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/logout?client_id=#{ENV['KEYCLOAK_CLIENT_ID']}&post_logout_redirect_uri=#{CGI.escape('http://localhost:3011')}", allow_other_host: true
    #redirect_to "http://localhost:8080/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/logout?client_id=#{ENV['KEYCLOAK_CLIENT_ID']}&post_logout_redirect_uri=http://localhost:3011", allow_other_host: true #?#{(params_key + params_login + ["redirect_uri=#{callback_url}"]).join('&')}"
  end

  def failure
    redirect_to root_path, alert: 'Authentication failed!'
  end

end