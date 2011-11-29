module Snafu
  module Locations
    def get_hubs
      hubs = []
      response = self.call("locations.getHubs")
      response["hubs"].each do |key,value|
        hubs << {:id => key, :name => value["name"]}
      end
      return hubs
    end

    def get_hub(hub_id)
      hub = nil
      response = nil
      streets = []

      response = self.call("locations.getStreets", :hub_id => hub_id)
      hub = Models::Hub.new(:id => response["hub_id"], :name => response["name"])
      streets = []
      response["streets"].each do |k,v|
        streets << {:id => k, :name => v[:name]}
      end
      hub.streets = streets
      return hub
    end

    def get_street(street_id)
      response = self.call("locations.streetInfo", :street_tsid => street_id)
      hub = Models::Hub.new(:id => response["hub"]["id"], :name => response["hub"]["name"])
      street = Models::Location.new(:id => response["tsid"],
                            :name => response["name"],
                            :hub => hub)
    end
  end
end