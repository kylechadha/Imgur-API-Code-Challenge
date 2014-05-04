class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :application

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def application
    @twitter ||= Twitter::REST::Client.new do |config|
      # Normally you would never leave these exposed
      config.consumer_key        = "EGtAiRXlnFzX90MPtkHA"
      config.consumer_secret     = "OkDiA6C0Ej2yBg9Jh6Rdhoxc25b5aMfQLRwbY1Mw0U"
    end
  end 
end
