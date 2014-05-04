class SessionsController < ApplicationController

  def create
    # Get back all oauth information from omniauth middleware
    auth = request.env["omniauth.auth"]

    # binding.pry ## Can use pry here to make sure our 'auth' variable looks good -- then find or create the user
    user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"], name: auth["info"]["name"], access_token: auth["credentials"]["token"], access_token_secret: auth["credentials"]["secret"])

    # Sign in and set the current session
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    # Log out
    session[:user_id] = nil
    redirect_to root_path
  end

end
