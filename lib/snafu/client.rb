module Snafu
  API_URL = 'http://api.glitch.com/simple'

  def self.new(options={})
    Snafu::Client.new(options)
  end

  class Client
    # it's p-p-p-party time
    include HTTParty
    
    # include other classes & modules so they can be called on self
    include Snafu::Locations
    include Snafu::Achievements
    include Snafu::Giants
    include Snafu::Util

    base_uri API_URL

    attr_accessor :oauth_token, :last_request_result

    def initialize(options={})
      @oauth_token = options[:oauth_token]
    end

    # Make a raw call to the Glitch API.
    #
    #   snafu = Snafu.new(:oauth_token => "some-token")
    #   snafu.call("calendar.getHolidays")
    #
    # For Glitch methods which require authentication, set <tt>:authentication => true</tt>
    #
    #   snafu = snafu.call("players.stats", :authenticate => true)
    #
    # Invalid method calls will raise a <tt>GlitchAPIError</tt>
    def call(method, query_parameters={})
      unless method.is_a? String
        raise ArgumentError.new("Method argument must be a string")
      end

      options = { :format => :json }
      unless query_parameters.empty?
        options[:query] = query_parameters
        if options[:query].has_key?(:authenticate) && options[:query][:authenticate] == true
          if self.oauth_token.nil?
            raise GlitchAuthenticationError.new("You cannot perform an authenticated call without an oauth token")
          end

          # Replace the authenticate key with the oauth token
          options[:query].delete(:authenticate)
          options[:query].update(:oauth_token => @oauth_token)
        end
      end
      request_uri = "/#{method}"
      parse_response(self.class.get(request_uri, options))
    end

    def parse_response(response)
      if response["error"] == "invalid_token"
        raise GlitchAuthenticationError.new("Invalid Token")
      elsif response["ok"] == 0
        if response["error"] == "missing_scope"
          raise GlitchAuthenticationError.new("The token supplied has insufficient scope for this API method")
        elsif response["error"] == "not_authenticated"
          raise GlitchAuthenticationError.new("This API method requires authentication and no OAuth token has been supplied")
        else
          raise GlitchAPIError.new(response["error"])
        end
      else
        @last_request_result = response
        response
      end
    end
  end

  class GlitchAPIError < StandardError;end
  class GlitchAuthenticationError < StandardError;end
end