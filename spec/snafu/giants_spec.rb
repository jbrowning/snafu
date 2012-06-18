require 'spec_helper'

describe Snafu::Giants do
  before(:each) do
    @snafu = Snafu.new()
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

  describe "#get_giants_favor", :if => defined?(GLITCH_OAUTH_READ_TOKEN) do

    before(:each) do
      @snafu = Snafu.new(:oauth_token => GLITCH_OAUTH_READ_TOKEN)
    end

    it "should raise an error if there is no OAuth token set" do
      snafu = Snafu.new
      expect { snafu.get_giants_favor }.to raise_error(Snafu::GlitchAuthenticationError)
    end
    
    it "should return a non-empty Array", :vcr do
      giants_favor = @snafu.get_giants_favor
      giants_favor.should be_an Array
      giants_favor.should_not be_empty
    end


    it "should return an Array of fully-populated Giant objects", :vcr do
      giants_favor = @snafu.get_giants_favor
      giants_favor.each do |giant| 
        giant.should be_a(Snafu::Models::Giant)
        giant.name.should_not be_empty
        giant.cur_favor.should_not be_nil
        giant.max_favor.should_not be_nil
        giant.cur_daily_favor.should_not be_nil
        giant.max_daily_favor.should_not be_nil
      end
    end
  end

end