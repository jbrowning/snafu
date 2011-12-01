module Snafu
  module Models
    class Location
      attr_reader :id, :name
      def initializer(options={})
        @id = options[:id]
        @name = options[:name]
      end
      def to_s
        "#{self.id} - #{self.name}"
      end
    end
  end
end