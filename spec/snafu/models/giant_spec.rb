require 'spec_helper'

module Snafu
  module Models
    describe Snafu::Models::Giant do

      GIANT_LIST = ["Alph", "Cosma", "Friendly", "Grendaline",
                    "Humbaba", "Lem", "Mab", "Pot", "Spriggan",
                    "Tii", "Zille" ]

      describe "#initialize" do
        let(:random_giant) { GIANT_LIST.sample }

        it "should populate values if given an options hash" do
          expected_name = random_giant
          expected_cur_favor = rand(1000)
          expected_max_favor = expected_cur_favor + 1
          expected_cur_daily_favor = rand(1000)
          expected_max_daily_favor = expected_cur_daily_favor + 1

          giant = Giant.new(
            :name => expected_name,
            :cur_favor => expected_cur_favor.to_s,
            :max_favor => expected_max_favor.to_s,
            :cur_daily_favor => expected_cur_daily_favor.to_s,
            :max_daily_favor => expected_max_daily_favor.to_s
          )

          giant.name.should eql(expected_name)
          giant.cur_favor.should eql(expected_cur_favor)
          giant.max_favor.should eql(expected_max_favor)
          giant.cur_daily_favor.should eql(expected_cur_daily_favor)
          giant.max_daily_favor.should eql(expected_max_daily_favor)
        end
      end
    end
  end
end