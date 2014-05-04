class SearchesController < ApplicationController
  def index
    # Set number of tweets to be displayed on initial search
    if params[:increment]
      @display = params[:increment].to_i
    else
      @display = 10
    end

    # If authenticated, use user oauth to search, otherwise use application oauth 
    if params[:search] and params[:search] != "" and current_user
      @results = current_user.twitter.search(params[:search], :count => @display, :lang => 'en')
    elsif params[:search] and params[:search] != ""
      @results = application.search(params[:search], :count => @display, :lang => 'en')
    end

    # Respond to AJAX javascript calls
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    # Create or add to each users favorited_tweets array
    @favorited_tweet = params[:tweet]
    current_user.favorited_tweets ||= []
    current_user.favorited_tweets << @favorited_tweet

    # Save it and redirect to searches#index
    if current_user.save
      redirect_to root_path(search: params[:search])
    end
  end
end
