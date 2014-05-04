class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :access_token, type: String
  field :access_token_secret, type: String
  field :favorited_tweets, type: Array

  # Define the twitter client on each user
  def twitter
    @twitter ||= Twitter::REST::Client.new do |config|
      # Normally you would never leave these exposed
      config.consumer_key        = "EGtAiRXlnFzX90MPtkHA"
      config.consumer_secret     = "OkDiA6C0Ej2yBg9Jh6Rdhoxc25b5aMfQLRwbY1Mw0U"
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end
  end 
end
