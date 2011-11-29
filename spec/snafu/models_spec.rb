require 'spec_helper'

describe Snafu::Models::Hub do
  it "should retain the ID & Name of the hub if given a valid " do
    hub = Snafu::Models::Hub.new(:id => @test_hub_id, :name => @test_hub_name)
    hub.id.should eql(@test_hub_id)
    hub.name.should eql(@test_hub_name)
  end
end