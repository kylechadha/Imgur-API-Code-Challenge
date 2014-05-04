class SearchesController < ApplicationController
  def index
    # Set number of tweets to be displayed on initial search
    if params[:increment]
      @display = params[:increment].to_i
    else
      @display = 10
    end

    if params[:search] and params[:search] != ""
      # Retrieve a list of the 100 most recent tweets by the specified user and run them through the extract_hashtags method defined on the Search model
      @results = Search.extract_hashtags(application.user_timeline(params[:search], :count => 100))

      @images = HTTParty.get "https://api.imgur.com/3/gallery/search/viral/0.json?q=icecream",
        {
      #     query: {
      #       q: "lemons"
      #     },
          headers: {
            "Authorization" => "Client-ID 032ea6a7302fa98"
          }
        }
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
