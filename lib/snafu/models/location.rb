module Snafu
  module Models
    # Defines a generic location class with <tt>id</tt> and <tt>name</tt> 
    # properties.
    class Location
      attr_reader :id, :name
      # Accepts an options hash with <tt>:id</tt> or <tt>:name</tt>
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