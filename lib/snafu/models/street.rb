module Snafu
  module Models
    class Street < Location
      attr_reader :hub, :connections, :mote, :image, :active_project
      alias_method :active_project?, :active_project
      def initialize(options = {})
        if options
          @id = options[:id]
          @name = options[:name]
          @hub = options[:hub]
          @connections = options[:connections] || []
          @mote = options[:mote]
          @image = options[:image]
          @active_project = options[:active_project] || false
        end
      end
    end
  end
end