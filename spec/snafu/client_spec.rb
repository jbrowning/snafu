require 'spec_helper'

describe Snafu::Client do
  before(:each) do
    @snafu = Snafu.new
  end

  describe '#call' do
    it 'should receive a successful response from the Glitch API if given an valid method', :vcr do
      result = @snafu.call("calendar.getHolidays")
      result['ok'].should eql(1)
    end

    it 'should raise a GlitchAPIError if receiving an unsucessful response from the Glitch API', :vcr do
      expect { @snafu.call("badmethod") }.to raise_error(Snafu::GlitchAPIError)
    end

    it 'should accept a hash of POST arguments', :vcr do
      hub_id = "27"
      hub_name = "Ix"
      result = @snafu.call("locations.getStreets", {:hub_id => "27"})
      result["name"].should eql(hub_name)
    end
    
    if defined? GLITCH_OAUTH_READ_TOKEN
      it "should automatically pass in the oauth token if called with authenticate", :vcr do
        snafu = Snafu.new(:oauth_token => GLITCH_OAUTH_READ_TOKEN)
        expect { response = snafu.call("players.stats", :authenticate => true) }.to_not raise_exception
      end
    end

    context "authentication" do
      it "should raise a GlitchAuthenticationError if trying to perform an authenticated call without an oauth token", :vcr do
        snafu = Snafu.new()
        expect { snafu.call("secureMethod", :authenticate => true) }.to raise_error(Snafu::GlitchAuthenticationError, /oauth token/)
      end

      it "should raise a GlitchAuthenticationError if calling the API with an invalid OAuth token", :vcr, :record => :all do
        snafu = Snafu.new(:oauth_token => "invalid token")
        expect { snafu.call("giants.getFavor", :authenticate => true) }.to raise_error(Snafu::GlitchAuthenticationError, /invalid token/i)
      end

      it 'should raise a GlitchAuthenticationError if calling an authenticated API method without a token', :vcr do
        expect { @snafu.call("giants.getFavor") }.to raise_error(Snafu::GlitchAuthenticationError)
      end

      if defined? GLITCH_OAUTH_READ_TOKEN
        it "should raise a GlitchAuthenticationError if calling a method that requires a higher scope", :vcr do
          snafu = Snafu.new(:oauth_token => GLITCH_OAUTH_IDENTITY_TOKEN)
          expect { snafu.call("giants.getFavor", :authenticate => true) }.to raise_error(/insufficient scope/)
        end
      end
    end
  end

  describe "#last_request_result" do
    it "should return the raw contents of the last request result", :vcr do 
      result = @snafu.call("calendar.getHolidays")
      @snafu.last_request_result.should eql(result)
    end
  end

end