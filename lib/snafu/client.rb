require 'httparty'

module Snafu
  API_URL = 'http://api.glitch.com/simple'

  def self.new(api_key="")
    if api_key.is_a?(String) && !api_key.empty?
      Snafu::Client.new(api_key)
    else
      raise ArgumentError.new("API key is required")
    end
  end

  class Client
    include HTTParty
    base_uri API_URL

    # include other classes & modules so they can be called on the returned client object
    include Snafu::Locations

    attr_accessor :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def call(method, query_parameters={})
      if method.is_a? String
        options = { :format => :json }
        unless query_parameters.empty?
          options[:query] = query_parameters
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