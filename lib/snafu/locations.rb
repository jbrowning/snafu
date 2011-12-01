module Snafu
  module Locations
    
    # Accesses the "locations.getHubs" method from the Glitch API 
    # and returns an Array of the returned Hub information.
    # 
    def get_hubs
      hubs = []
      response = self.call("locations.getHubs")
      response["hubs"].each do |key,value|
        hubs << Models::Hub.new(:id => key, :name => value["name"])
      end
      hubs
    end

    # Accesses the "locations.getStreets" method from the Glitch API passing in
    # the supplied Hub ID.
    # 
    def get_hub(hub_id)
      response = self.call("locations.getStreets", :hub_id => hub_id)
      Models::Hub.new(response)
    end

    # Accesses the "locations.streetInfo" method from the Glitch API padding in
    # the supplied street ID
    # 
    def get_street(street_id)
      response = self.call("locations.streetInfo", :street_tsid => street_id)
      Models::Street.new(response)
    end
  end
end