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

    # Calculate frequency of hashtags used, and sort in descending order
    user_hashtags = user_hashtags.each_with_object(Hash.new(0)){ |m,h| h[m] += 1 }.sort_by{ |k,v| v }.reverse!

    # Limit the response to the top 10 hashtags used
    user_hashtags.take(10)
  end  

end
