module Snafu
  module Giants

    # Accesses the "giants.list" method from the Glitch API and returns an array of the
    # Giant information
    def get_giants
      giants = []
      response = self.call("giants.list")
      response["giants"].each do |short_name, long_name|
        giants << Models::Giant.new(:name => long_name)
      end
      giants
    end

    # Accesses the "giants.getFavor" method from the Glitch API and returns an array of
    # giants with their respective favor for the authenticated users
    #
    # Requires an OAuth token with *read* scope
    #
    def get_giants_favor
      giants = []
      reponse = self.call("giants.getFavor", :authenticate => true)
      reponse["giants"].each do |giant_short_name, giant_values|
        giants << Models::Giant.new(
          :name => giant_values["name"],
          :cur_favor => giant_values["cur_favor"],
          :max_favor => giant_values["max_favor"],
          :cur_daily_favor => giant_values["cur_daily_favor"],
          :max_daily_favor => giant_values["max_daily_favor"]
          )
      end
      giants
    end
  end
end