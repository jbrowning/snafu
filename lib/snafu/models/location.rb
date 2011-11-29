module Snafu
  module Models
    class Location
      attr_accessor :id, :name, :hub, :connections
      def initialize(options = {})
        if options
          @id = options[:id]
          @name = options[:name]
          @hub = options[:hub]
        end
      end
    end
  end
end