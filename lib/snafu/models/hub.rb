module Snafu
  module Models
    # Defines a class for Glitch Hubs, which are the various regions in the game.
    # 
    class Hub < Location
      attr_reader :streets
      
      # Accepts either the raw JSON-formatted response from the HTTParty get request or an options
      # hash.
      # 
      def initialize(options = {})
        if options.class == HTTParty::Response
          # construct the street information
          @id = options["hub_id"]
          @name = options["name"]
          @streets = []
          options["streets"].each do |street_id, street|
            @streets << {:id => street_id, :name => street["name"]}
          end
        else
          @id = options[:id]
          @name = options[:name]
          if options[:streets].is_a? Array
            @streets = options[:streets]
          else
            @streets = [options[:streets]]
          end
        end
      end
    end
  end
end