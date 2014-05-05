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

    # Limit the response to the top 6 hashtags used
    user_hashtags.take(6)
  end

  def self.imgur_search(hashtags)
    # Create an empty hash to store the image URLs
    image_urls = {}

    # For each hashtag conduct an image search via Imgur's API
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

      # Store the URLs in a hash, with the hashtags as keys
      search_results['data'].each do |image|
        image_urls[hashtag[0]] ||= []
        
        # Validate that the URL is a valid image
        if image['link'].scan(/[\w-]+\.(gif|png|jpg|jpeg)/).length > 0
          image_urls[hashtag[0]].push(image['link'])
        end
      end
    end

    # Return the hash of image URLs
    return image_urls
  end

end
