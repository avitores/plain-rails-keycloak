# # the realm that contains the open-client client
# RailsKeycloakAuthorization.keycloak_auth_client_realm_name = ENV.fetch("KEYCLOAK_REALM", "dummy")

# # the subject open-id client containing
# RailsKeycloakAuthorization.keycloak_auth_client_id         = ENV.fetch("KEYCLOAK_CLIENT_ID", "dummy-client")

# # keycloak server_url
# RailsKeycloakAuthorization.keycloak_server_url             = ENV.fetch("KEYCLOAK_URL", "http://localhost:8080")

# # keycloak server_domain
# RailsKeycloakAuthorization.keycloak_server_domain          = ENV.fetch("KEYCLOAK_ADMIN_SERVER_DOMAIN", "localhost")

# # keycloak realm that contains the admin-client
# RailsKeycloakAuthorization.keycloak_admin_realm_name       = ENV.fetch("KEYCLOAK_ADMIN_REALM_NAME", "master")

# # keycloak admin_client 
# RailsKeycloakAuthorization.keycloak_admin_client_id        = ENV.fetch("KEYCLOAK_ADMIN_CLIENT_ID", "keycloak-admin")

# # keycloak admin_client's secret
# RailsKeycloakAuthorization.keycloak_admin_client_secret    = ENV.fetch("KEYCLOAK_CLIENT_SECRET", "keycloak-admin-client-secret-xxx")

# # List of regext for pattern to protect
# RailsKeycloakAuthorization.match_patterns                  = [
#   /^\/organizations\.json/,
#   /^\/api\/projects/,
#   /^\/secrets\.json/,
#   /^\/api\/secrets/
#]