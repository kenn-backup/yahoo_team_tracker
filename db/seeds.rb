require 'Faker'

# Variables #################################################
positions = %w[ C LW RW D G ]

pro_teams = %w[ Flyers Rangers Islanders Devils Sabres Sharks Leafs Kings ]

age = (20..38).to_a

players_index = (1..40).to_a

# Players ####################################################
40.times do
  Player.create(last_name: Faker::Name.last_name, first_name: Faker::Name.first_name, position: positions.sample, pro_team: pro_teams.sample, age: age.sample )
end

# Teams ######################################################
Team.create(name: Faker::Company.name, user_id: 1) #Team_id 1
Team.create(name: Faker::Company.name, user_id: 1) #Team_id 2
Team.create(name: Faker::Company.name, user_id: 2) #Team_id 3
Team.create(name: Faker::Company.name, user_id: 3) #Team_id 4

# Users ######################################################
3.times do
  User.create(username: Faker::Internet.user_name, email: Faker::Internet.free_email, password: Faker::Internet.password)
end

# TeamPlayers ################################################
5.times do
  TeamPlayer.create(team_id: 1, player_id: players_index.sample)
end

5.times do
  TeamPlayer.create(team_id: 2, player_id: players_index.sample)
end

5.times do
  TeamPlayer.create(team_id: 3, player_id: players_index.sample)
end

5.times do
  TeamPlayer.create(team_id: 4, player_id: players_index.sample)
end
