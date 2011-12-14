module Snafu
  module Models
    class Street < Location
      attr_reader :hub, :connections, :mote, :features, :image, :active_project
      alias_method :active_project?, :active_project
      def initialize(options = {})
        if options.class == HTTParty::Response
          @id = options["tsid"]
          @name = options["name"]
          @hub = Hub.new(:id => options["hub"]["id"], :name => options["hub"]["name"])
          @features = options["features"]
          @connections = []
          options["connections"].each do |street_id, street|
            @connections << Street.new(
              :id => street_id,
              :name => street["name"],
              :hub => Hub.new(:id => options["hub"]["id"], :name => options["hub"]["name"]),
              :mote => Hub.new(:id => options["mote"]["id"], :name => options["mote"]["name"]),
            )
          end
          @mote = Hub.new(:id => options["mote"]["id"], :name => options["mote"]["name"])

          unless options["image"].nil?
            @image = GlitchImage.new(
              :url => options["image"]["url"],
              :width => options["image"]["w"],
              :height => options["image"]["h"]
            )
          end

          @active_project = options["active_project"]
        else
          @id = options[:id]
          @name = options[:name]
          @hub = options[:hub]
          @features = options[:features]
          @connections = options[:connections] || []
          @mote = options[:mote]
          @image = options[:image]
          @active_project = options[:active_project] || false
        end
      end
    end
  end
end