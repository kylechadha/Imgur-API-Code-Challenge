class Search
  include Mongoid::Document

  # Played around with doing oauth by hand, but didn't have enough time to build out the full functionality... was interesting to dig deeper into oauth though. (...But can see why it's not most people's favorite thang x_x)

  # require 'oauth_util.rb'
  # def self.request(keywords)

    # oauth = OauthUtil.new
    # parsed_url = URI.parse('https://api.twitter.com/1.1/search/tweets.json?q=monkeys')
    # signed_params = oauth.sign(parsed_url).params

    # oauth_consumer_key = signed_params['oauth_consumer_key']
    # oauth_nonce = signed_params['oauth_nonce']
    # oauth_signature = signed_params['oauth_signature']
    # oauth_signature_method = signed_params['oauth_signature_method']
    # oauth_timestamp = signed_params['oauth_timestamp']
    # oauth_token = signed_params['oauth_token']

    # authorization = 'OAuth oauth_consumer_key="' + oauth_consumer_key +'", oauth_nonce="' + oauth_nonce + '", oauth_signature="' + oauth_signature + '", oauth_signature_method="HMAC-SHA1", oauth_timestamp="' + oauth_timestamp + '", oauth_token="' + oauth_token + '", oauth_version="1.0"'

    # HTTParty.get "https://api.twitter.com/1.1/search/tweets.json", 
    #   {
    #     query: {
    #       q: keywords
    #     },
    #     headers: {
    #       "Authorization" => authorization
    #       # "Content-Type" => "application/x-www-form-urlencoded"
    #     }
    #   }

  # end

end
