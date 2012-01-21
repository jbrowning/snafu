require 'spec_helper'

describe Snafu::Locations do
  before(:each) do
    @snafu = Snafu.new(:api_key => GLITCH_API_KEY, :oauth_token => GLITCH_OAUTH_TOKEN)
    @test_hub_id = 27
    @test_hub_name = "Ix"
    @test_street_id = "LM416LNIKVLM1"
    @test_street_name = "Baby Steppes"
  end

  context "#get_hubs" do
    before(:each) do
      @hubs = @snafu.get_hubs
    end

    it "should return an array of all hubs", :vcr do
      @hubs.should_not be_empty
    end

    it "should return an array of Hub objects", :vcr do
      @hubs.first.should be_a Snafu::Models::Hub
    end

    it "should populated the returned Hub objects with an id and name", :vcr do
      first_hub = @hubs.first
      first_hub.id.should_not be_nil
      first_hub.name.should_not be_nil
    end
  end

  context "#get_hub" do
    it "should return a valid hub if given a valid Hub ID", :vcr do
      hub = @snafu.get_hub(@test_hub_id)
      hub.name.should eql(@test_hub_name)
    end

    it "should return an array of valid street information if given a valid Hub ID", :vcr do
      test_array = {:id => @test_street_id, :name => @test_street_name}
      hub = @snafu.get_hub(@test_hub_id)
      hub.streets.should include(test_array)
    end
  end

  context "#get_street" do
    before(:each) do
      @test_street = @snafu.get_street(@test_street_id)
    end

    it "should return a complete street if given a valid street ID", :vcr do
      @test_street.id.should_not be_nil
      @test_street.name.should_not be_nil
      @test_street.mote.should_not be_nil
      @test_street.active_project?.should_not be_nil
      @test_street.connections.should_not be_empty
      @test_street.image.url.should_not be_nil
      @test_street.image.width.should_not be_nil
      @test_street.image.height.should_not be_nil
    end
  end
end