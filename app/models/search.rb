class Search
  include Mongoid::Document

  def self.extract_hashtags(user_tweets)
    # Create a new array to store the user's hashtags
    user_hashtags = Array.new

    # Scan each tweet for hashtags, strip the results of unwanted characters, and push each hashtag to the user_hashtags array
    user_tweets.each do |tweet|
      tweet_hashtags = tweet.text.scan(/#\S+/)
      tweet_hashtags.each do |hashtag|
        user_hashtags.push(hashtag.gsub(/[^0-9A-Za-z#]/, ''))
      end
    end

    # Return a unique list of user hashtags
    user_hashtags.uniq
  end  

end
