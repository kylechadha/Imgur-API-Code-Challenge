class SearchesController < ApplicationController
  
  def index
    if params[:search] and params[:search] != ""
      # Retrieve a list of the 100 most recent tweets by the specified user and run them through the extract_hashtags method defined on the Search model
      binding.pry
      @results = Search.extract_hashtags(application.user_timeline(params[:search], :count => 100))

      # Search Imgur's API for pictures that match the hashtags retrieved above
      @images = Search.imgur_search(@results)
    end
  end

end
