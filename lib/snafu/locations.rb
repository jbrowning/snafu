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
      response = self.call("locations.getStreets", :hub_id => hub_id)
      hub = Hub.new(:id => response["hub_id"], :name => response["name"])
      streets = []
      response["streets"].each do |k,v|
        streets << {:id => k, :name => v[:name]}
      end
      hub.streets = streets
      return hub
    end

    # Models

    class Hub
      attr_accessor :id, :name, :streets
      def initialize(options = {})
        @id = options[:id]
        @name = options[:name]
        @streets = options[:streets]
      end

      def to_s
        "#{@id} - #{@name}"
      end
    end

    class Location
      attr_accessor :id, :name, :hub, :connections
      def initialize(options = {})
        if options
          @id = options[:id]
          @name = options[:name]
          @hub = options[:name]
        end
      end
    end
  end
end