module Snafu
  module Giants

    # Accesses the "giants.list" method from the Glitch API and returns an array of the
    # returned Giant information
    def get_giants
      giants = []
      response = self.call("giants.list")
      response["giants"].each do |short_name, long_name|
        giants << Models::Giant.new(:name => long_name)
      end
      giants
    end

  end
end