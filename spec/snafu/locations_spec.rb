require 'spec_helper'

describe Snafu::Locations do
  before(:each) do
    @snafu = Snafu.new("test-key")
    @test_hub_id = 27
    @test_hub_name = "Ix"
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

    it "should return a hub if given a valid Hub ID" do
      hub = @snafu.get_hub(@test_hub_id)
      hub.name.should eql(@test_hub_name)
    end

    it "should return an array of all locations if given a valid Hub object" do
      hub = Hub.new(:id => @test_hub_id, :name => @test_hub_name)
      hub 
    end
  end

  describe Snafu::Locations::Hub do
    Hub = Snafu::Locations::Hub
    it "should retain the ID & Name of the hub if given a valid " do
      id = "27"
      name = "Ix"
      hub = Hub.new(:id => id, :name => name)
      hub.id.should eql(id)
      hub.name.should eql(name)
    end
  end

  describe Snafu::Locations::Location do
    Location = Snafu::Locations::Location
  end
end