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
    user_hashtags = user_hashtags.each_with_object(Hash.new(0)){ |m,h| h[m.downcase] += 1 }.sort_by{ |k,v| v }.reverse!

    # Limit the response to the top 5 hashtags used
    user_hashtags.take(5)
  end

  def self.imgur_search(hashtags)
    image_urls = {}

    hashtags.each do |hashtag|
      search_results = HTTParty.get "https://api.imgur.com/3/gallery/search/viral/0.json",
        {
          query: {
            q: hashtag[0]
          },
          headers: {
            "Authorization" => "Client-ID 032ea6a7302fa98"
          }
        }

      search_results['data'].each do |image|
        image_urls[hashtag[0]] ||= []
        image_urls[hashtag[0]].push(image['link'])
      end
    end

    return image_urls
  end

end
