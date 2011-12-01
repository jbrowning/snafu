require 'spec_helper'

describe Snafu::Client do
  before(:each) do
    @snafu = Snafu.new("testkey")
  end

  describe 'call' do
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
  end
end