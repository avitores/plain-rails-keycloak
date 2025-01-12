class WelcomeController < ApplicationController
  def index
    @user = session[:user_info]
  end
end
