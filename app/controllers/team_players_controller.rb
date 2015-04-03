class TeamPlayersController < ApplicationController

	def add_player # Change this to create method and remove the route	

		new_player = Player.find_by_id(params[:player_id].to_i)
		
		TeamPlayer.create(player_id: new_player.id, team_id: params[:id].to_i)

		render json: {player_name: "#{new_player.last_name}, #{new_player.first_name}", position: "#{new_player.position}", pro_team: "#{new_player.pro_team}", age: "#{new_player.age}"}
	end

	def release_player

		p "#"*40
		p params
		p "#"*40


		200
		# TeamPlayer.find_by(player_id: params[:player_id].to_i, team_id: params[:id].to_i).destroy
	end

end
