require 'spec_helper'

module Snafu
  module Models
    describe Snafu::Models::Hub do
      context "initialize()" do
        it "should populate values if given an options hash" do
          expected_id = "1"
          expected_name = "Some Hub"
          expected_street = {:id => "2", :name => "Some Street"}
          new_hub = Hub.new(
            :id => expected_id,
            :name => expected_name,
            :streets => expected_street
          )
          new_hub.id.should eql(expected_id)
          new_hub.name.should eql(expected_name)
          new_hub.streets.first.should eql(expected_street)
        end

        it "should populate values if given the raw response from Glitch", :vcr do
          glitch_client = Snafu.new("test-key")
          glitch_response = glitch_client.call("locations.getStreets", :hub_id => 27)
          new_hub = Hub.new(glitch_response)
          new_hub.streets.should_not be_nil
        end

        it "should accept an array for the :streets parameter" do
          expected_value = [{:id => "2", :name => "Some Street"}]
          new_hub = Hub.new(:streets => expected_value)
          new_hub.streets.should eql(expected_value)
        end

        it "should accept a hash for the :streets parameter" do
          street_hash = {:id => "2", :name => "Some Street"}
          expected_value = [street_hash]
          new_hub = Hub.new(:streets => street_hash)
          new_hub.streets.should eql(expected_value)
        end
      end
    end
  end
end
