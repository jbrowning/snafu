require 'spec_helper'

describe Snafu::Client do
  before(:each) do
    @snafu = Snafu.new(:api_key => GLITCH_API_KEY, :oauth_token => GLITCH_OAUTH_TOKEN)
  end

  describe '#call' do
    it 'should receive a successful response from the Glitch API if given an valid method', :vcr do
      VCR.use_cassette "calendar.getHoldays/valid_calendar" do
        result = @snafu.call("calendar.getHolidays")
        result['ok'].should eql(1)
      end
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
    
    it "should automatically pass in the oauth token if called with authenticate", :vcr do
      expect { response = @snafu.call("players.stats", :authenticate => true) }.to_not raise_exception
    end


    context "without oauth token" do
      it "should raise a GlitchAPIError if trying to do an authenticated call without an oauth token" do
        snafu = Snafu.new()
        expect { snafu.call("secureMethod", :authenticate => true) }.to raise_error(Snafu::GlitchAPIError, /oauth token/)
      end        
    end

  end

end