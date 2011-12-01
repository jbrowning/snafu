require 'spec_helper'

module Snafu
  module Models
    describe Snafu::Models::Street do
      before(:each) do
        @snafu = Snafu.new("test-key")
        @test_hub_id = 27
        @test_hub_name = "Ix"
        @test_street_id = "LM416LNIKVLM1"
        @test_street_name = "Baby Steppes"
      end
      context "initialize()" do
        it "should populate values if given an options hash", :vcr do
          expected_id = "1"
          expected_name = "Some street"
          expected_hub = Hub.new(:id => "2", :name => "Some Hub")
          expected_connections = [Street.new(:id => "3", :name => "Connected Street")]
          expected_mote = Hub.new(:id => "4", :name => "Some Mote")
          expected_features = "some features"
          expected_image = GlitchImage.new(:url => "http://example.com/image.png", :width => "100", :height => "100")
          expected_active_project = false
          new_street = Street.new(
            :id => expected_id,
            :name => expected_name,
            :hub => expected_hub,
            :features => expected_features,
            :connections => expected_connections,
            :active_project => expected_active_project,
            :mote => expected_mote,
            :image => expected_image,
          )

          new_street.id.should eql(expected_id)
          new_street.name.should eql(expected_name)
          new_street.hub.should eql(expected_hub)
          new_street.features.should eql(expected_features)
          new_street.connections.should eql(expected_connections)
          new_street.mote.should eql(expected_mote)
          new_street.image.should eql(expected_image)
          new_street.active_project.should eql(expected_active_project)
        end

        it "should populate values if given the raw JSON response from HTTParty", :vcr do
          response = @snafu.call("locations.streetInfo", :street_tsid => @test_street_id)
          expected_id = response["tsid"]
          expected_name = response["name"]
          expected_hub = Hub.new(:id => response["hub"]["id"], :name => response["hub"]["name"])
          expected_features = response["features"]
          expected_connections = []
          response["connections"].each do |street_id, street|
            expected_connections << Street.new(
              :id => street_id,
              :name => street["name"],
              :hub => Hub.new(:id => response["hub"]["id"], :name => response["hub"]["name"]),
              :mote => Hub.new(:id => response["mote"]["id"], :name => response["mote"]["name"]),
            )
          end
          expected_mote = Hub.new(:id => response["mote"]["id"], :name => response["mote"]["name"])
          expected_image = GlitchImage.new(
            :url => response["image"]["url"],
            :width => response["image"]["w"],
            :height => response["image"]["h"]
          )
          expected_active_project = response["active_project"]

          new_street = Street.new(response)

          new_street.id.should eql(expected_id)
          new_street.name.should eql(expected_name)
          new_street.hub.name.should eql(expected_hub.name)
          new_street.features.should eql(expected_features)
          new_street.connections.count.should eql(expected_connections.count)
          new_street.mote.name.should eql(expected_mote.name)
          new_street.image.url.should eql(expected_image.url)
          new_street.active_project.should eql(expected_active_project)
        end
      end
    end
  end
end