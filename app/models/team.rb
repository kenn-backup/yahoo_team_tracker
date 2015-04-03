class Team < ActiveRecord::Base
  belongs_to :user
  has_many :team_players
  has_many :players, through: :team_players
end
