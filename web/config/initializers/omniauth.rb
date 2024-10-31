Rails.application.config.middleware.use OmniAuth::Builder do

  
  provider :keycloak_openid, 
    ENV['KEYCLOAK_CLIENT_ID'],
    ENV['KEYCLOAK_CLIENT_SECRET'],
    {
      client_options: {
        base_url: '',
        site: ENV['KEYCLOAK_URL'],
        realm: ENV['KEYCLOAK_REALM'],
        auth_provider: 'keycloak_openid',
        state: Proc.new { SecureRandom.hex(32) },
        #ssl: { verify: false }
        # authorize_url: "http://loclhost:8080/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/auth",
        # token_url: "http://loclhost:8080/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/token",
        # userinfo_url: "http://loclhost:8080/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/userinfo",
        #authorize_url: "http://loclhost:8080/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/auth",
        # token_url: "#{ENV['KEYCLOAK_URL']}/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/token",
        # userinfo_url: "#{ENV['KEYCLOAK_URL']}/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/userinfo"
      },
      scope: 'openid email profile',
      # redirect_uri: "http://localhost:3011/users/auth/keycloak_openid/callback",
      # protect_against_csrf: false
    }
  # provider  :keycloak_openid, 
  #           ENV['KEYCLOAK_CLIENT_ID'],
  #           ENV['KEYCLOAK_CLIENT_SECRET'],
  #           client_options: { 
  #                             base_url: '',
  #                             site: ENV['KEYCLOAK_URL'],
  #                             realm: ENV['KEYCLOAK_REALM'],
  #                             ssl: false 
  #                           },
  #           name: "keycloak"

  # provider :keycloak_openid,
  #   ENV.fetch("KEYCLOAK_CLIENT_ID", "dummy-client"),
  #   ENV.fetch("KEYCLOAK_CLIENT_SECRET", "dummy-client-super-secret-xxx"),
  #   client_options: {
  #     site: ENV.fetch("KEYCLOAK_URL", "http://localhost:8080"),
  #     realm: ENV.fetch("KEYCLOAK_REALM", "dummy"),
  #     raise_on_failure: true,
  #     base_url: ""
  #   },
  #   name: "keycloak",
  #   provider_ignores_state: true
end
#OmniAuth::AuthenticityTokenProtection.default_options(key: "csrf.token", authenticity_param: "_csrf")

OmniAuth.config.logger = Rails.logger

#OmniAuth.config.path_prefix = ENV.fetch("KEYCLOAK_AUTH_SERVER_PATH_PREFIX", "/oauth")
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if Rails.env.development?
