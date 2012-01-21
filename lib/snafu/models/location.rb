module Snafu
  module Models
    # Defines a generic location class with <tt>id</tt> and <tt>name</tt> 
    # properties.
    class Location
      attr_reader :name
      # Accepts an options hash with <tt>:id</tt> or <tt>:name</tt>
      def initializer(options={})
        @id = options[:id].to_s
        @name = options[:name]
      end
      def id
        @id.to_s
      end
      def to_s
        "Glitch Generic Location: ID: #{self.id} - Name: #{self.name}"
      end
    end
  end
end