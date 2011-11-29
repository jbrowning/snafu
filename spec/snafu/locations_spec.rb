require 'spec_helper'

describe Snafu::Locations do
  before(:each) do
    @snafu = Snafu.new("test-key")
    @test_hub_id = 27
    @test_hub_name = "Ix"
    @test_street_id = "LM416LNIKVLM1"
    @test_street_name = "Baby Steppes"
  end

  context "get_hubs" do
    it "should return an array of all hubs" do
      hubs = @snafu.get_hubs
      hubs.length.should be > 0
    end

    it "should return valid hub names and IDs" do
      hubs = @snafu.get_hubs
      first_hub = hubs.first
      first_hub[:id].should_not be_nil
      first_hub[:name].should_not be_nil
    end
  end

  context "get_hub" do
    it "should return a valid hub if given a valid Hub ID" do
      hub = @snafu.get_hub(@test_hub_id)
      hub.name.should eql(@test_hub_name)
    end
  end

  context "get_street" do
    before(:each) do
      @test_street = @snafu.get_street(@test_street_id)
    end

    it "should return a street if given a valid street ID" do
      @test_street.id.should_not be_nil
      @test_street.name.should_not be_nil
    end

    it "should contain a reference to its parent hub" do
      @test_street.hub.id.should_not be_nil
      @test_street.hub.name.should_not be_nil
    end

    it "should contain connections to adjacent locations"
  end
end