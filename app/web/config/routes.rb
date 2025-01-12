Rails.application.routes.draw do
  root "home#index"

  get '/callback', to: 'sessions#create', as: :auth_callback
  get '/init', to: 'sessions#init', as: :auth_init
  get '/get_token/:authorization_code', to: 'sessions#get_token', as: :session_get_token
  get '/get_user_info/:access_token', to: 'sessions#get_user_info', as: :session_get_user_info
  get '/init_session', to: 'sessions#init_session', as: :session_init_session
  get '/logout', to: 'sessions#destroy'

  get "up" => "rails/health#show", as: :rails_health_check
end
