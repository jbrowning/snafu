require 'spec_helper'

describe Snafu::Giants do
  before(:each) do
    @snafu = Snafu.new(:api_key => GLITCH_API_KEY, :oauth_token => GLITCH_OAUTH_TOKEN)
  end

  describe "#get_giants" do
    let(:giants) { @snafu.get_giants }

    it "should return a non-empty array", :vcr do
      giants.should be_an Array
      giants.should_not be_empty
    end
    
    it "should return an array of Giant objects", :vcr do
      giants.each do |element|
        element.should be_a Snafu::Models::Giant
      end
    end

    it "should have populate the returned Giant objects with a name", :vcr do
      giants.each do |giant|
        giant.name.should_not be_empty
      end
    end
  end
end