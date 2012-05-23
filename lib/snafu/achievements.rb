module Snafu
  module Achievements
    def get_achievements
      result = []
      response = self.call("achievements.listAll", :per_page => self.achievement_count)
      response["items"].each do |achievement|
        result << Models::Achievement.new(achievement[1])
      end
      result
    end

    def achievement_count
      response = self.call("achievements.listAll")
      response["total"]
    end
  end
end