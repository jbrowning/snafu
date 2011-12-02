module Snafu
  API_URL = 'http://api.glitch.com/simple'

  def self.new(options={})
    Snafu::Client.new(options)
  end

  class Client
    # it's p-p-p-party time
    include HTTParty
    
    # include other classes & modules so they can be called on the returned client object
    include Snafu::Locations
    
    base_uri API_URL

    attr_accessor :oauth_token

    def initialize(options={})
      @oauth_token = options[:oauth_token]
    end

    def call(method, query_parameters={})
      if method.is_a? String
        options = { :format => :json }
        unless query_parameters.empty?
          options[:query] = query_parameters
          if options[:query].has_key?(:authenticate) && options[:query][:authenticate] == true
            if self.oauth_token.nil?
              raise GlitchAPIError.new("You cannot do an authenticated call without an oauth token")
            end
            options[:query].delete(:authenticate)
            options[:query].update(:oauth_token => GLITCH_OAUTH_TOKEN)
          end
        end
        request_uri = "/#{method}"
        parse_response(self.class.get(request_uri, options))
      else
        raise ArgumentError.new("Method argument must be a string")
      end
    end

    def parse_response(response)
      if response["ok"] == 0
        raise GlitchAPIError.new(response["error"])
      else
        response
      end
    end
  end



  class GlitchAPIError < StandardError;end
end