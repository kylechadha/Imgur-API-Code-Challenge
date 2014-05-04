 
require 'uri'
require 'cgi'
require 'openssl'
require 'base64'

class OauthUtil
  
  attr_accessor :consumer_key, :consumer_secret, :token, :token_secret, :req_method, 
                :sig_method, :oauth_version, :callback_url, :params, :req_url, :base_str

  def initialize
    @consumer_key = ''
    @consumer_secret = ''
    @token = ''
    @token_secret = ''
    @req_method = 'GET'
    @sig_method = 'HMAC-SHA1'
    @oauth_version = '1.0'
    @callback_url = 'https://api.twitter.com/1.1/search/tweets.json'
  end
  
  def nonce
    Array.new( 5 ) { rand(256) }.pack('C*').unpack('H*').first
  end
  
  def percent_encode( string )
    return URI.escape( string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]") ).gsub('*', '%2A')
  end
  
  def signature
    key = percent_encode( @consumer_secret ) + '&' + percent_encode( @token_secret )
    digest = OpenSSL::Digest::Digest.new( 'sha1' )
    hmac = OpenSSL::HMAC.digest( digest, key, @base_str )
    
    Base64.encode64( hmac ).chomp.gsub( /\n/, '' )
  end
  
  def query_string
    pairs = []
    @params.sort.each { | key, val | 
      pairs.push( "#{ percent_encode( key ) }=#{ percent_encode( val.to_s ) }" )
    }
    pairs.join '&'
  end
  
  def sign( parsed_url )
    
    @params = {
      'oauth_consumer_key' => @consumer_key,
      'oauth_nonce' => nonce,
      'oauth_signature_method' => @sig_method,
      'oauth_timestamp' => Time.now.to_i.to_s,
      'oauth_token' => @token,
      'oauth_version' => @oauth_version
    }
    
    if parsed_url.query
      CGI.parse( parsed_url.query ).each do |k,v|
        if v.is_a?(Array) && v.count == 1
          @params[k] = v.first
        else
          @params[k] = v
        end
      end
    end
    
    @req_url = parsed_url.scheme + '://' + parsed_url.host + parsed_url.path
    
    @base_str = [ 
      @req_method, 
      percent_encode( req_url ), 
      percent_encode( query_string ) 
    ].join( '&' )
 
    @params[ 'oauth_signature' ] = signature
    
    return self
  end
end