module Snafu
  module Models
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
  end
end