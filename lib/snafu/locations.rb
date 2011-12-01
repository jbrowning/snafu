module Snafu
  module Locations
    def get_hubs
      hubs = []
      response = self.call("locations.getHubs")
      response["hubs"].each do |key,value|
        hubs << Models::Hub.new(:id => key, :name => value["name"])
      end
      hubs
    end

    def get_hub(hub_id)
      response = self.call("locations.getStreets", :hub_id => hub_id)
      Models::Hub.new(response)
    end

    def get_street(street_id)
      connections = []

      response = self.call("locations.streetInfo", :street_tsid => street_id)

      response["connections"].each do |street_id, street|
        connections << Models::Street.new(
          :id => street_id,
          :name => street["name"],
          :hub => Models::Hub.new(:id => street["hub"]["id"], :name => street["hub"]["name"]),
          :mote => Models::Hub.new(:id => street["mote"]["id"], :name => street["mote"]["name"])
        )
      end

      Models::Street.new(
        :id => response["tsid"],
        :name => response["name"],
        :hub => Models::Hub.new(:id => response["hub"]["id"], :name => response["hub"]["name"]),
        :mote => Models::Hub.new(:id => response["mote"]["id"], :name => response["mote"]["name"]),
        :features => response["features"],
        :image => Models::GlitchImage.new(
          :url => response["image"]["url"],
          :width => response["image"]["w"],
          :height => response["image"]["h"]
        ),
        :connections => connections
      )
    end
  end
end