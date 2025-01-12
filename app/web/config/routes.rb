Rails.application.routes.draw do
  # get "sessions/create"
  # get "sessions/destroy"
  # get "home/index"
  #devise_for :users
  #devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  # Devise.setup do |config|
  #   # ...
  #   devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # end
  
  # get '/auth/:provider/callback', to: 'sessions#create'
  # get '/auth/failure', to: redirect('/')
  # get '/logout', to: 'sessions#destroy'

  #get "/oauth/:provider/callback", to: "oauth#create"

  #get '/auth/:provider/callback', to: 'sessions#create'
  #get '/auth/failure', to: 'sessions#failure'
  #get '/signout', to: 'sessions#destroy', as: 'signout'

  # get '/auth/:provider/callback', to: 'sessions#create', as: :auth_callback
  # get '/auth/failure', to: 'sessions#failure', as: :auth_failure
  # #get '/auth/keycloak_openid', to: redirect('/auth/keycloak_openid')
  # #get '/auth/keycloak_openid', as: :keycloak_login
  # callback =  "http://localhost:3011/auth/keycloakopenid/callback"
  # get '/auth/keycloak_openid', to: redirect("http://localhost:8080/realms/#{ENV['KEYCLOAK_REALM']}/protocol/openid-connect/auth?client_id=#{ENV['KEYCLOAK_CLIENT_ID']}&redirect_uri=#{callback}&response_type=code&scope=openid")

  # get '/signout', to: 'sessions#destroy', as: 'signout'

  # Ruta para el callback de OmniAuth
  #get '/auth/:provider/callback', to: 'sessions#create', as: :auth_callback

  get '/callback', to: 'sessions#create', as: :auth_callback
  get '/init', to: 'sessions#init', as: :auth_init
  get '/get_token/:authorization_code', to: 'sessions#get_token', as: :session_get_token
  get '/get_user_info/:access_token', to: 'sessions#get_user_info', as: :session_get_user_info
  get '/init_session', to: 'sessions#init_session', as: :session_init_session
  #get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure', as: :auth_failure
  get '/logout', to: 'sessions#destroy'

  # Ruta para iniciar sesión, esto activará OmniAuth
  #get '/auth/keycloak_openid', as: :keycloak_login

  # Ruta de cierre de sesión
  #get '/signout', to: 'sessions#destroy', as: 'signout'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
end
