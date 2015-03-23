class TeamsController < ApplicationController

  def show
  	@team = Team.find(params[:id])
  end

  def edit
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  	@players = Player.all.order(last_name: :asc)
  end

  def delete
    @team = Team.find(params[:id])
  end

  def create
    new_team = Team.create(name: params[:team][:name], user_id: session[:id])
    params[:players].each_value do |player_id|
      TeamPlayer.create(player_id: player_id, team_id: new_team.id) 
    end
    redirect_to "/teams/#{new_team.id}"
  end

  def destroy
    Team.find_by(id: params[:id]).destroy
    redirect_to "/users/#{session[:id]}"
  end

  def add_player
    # p "*"*30
    # p params
    # p "*"*30
    respond_to do |format|
      format.html { render partial: 'players/add_player', locals: {players: Player.all, num_players: params[:player_count].to_i} }
    end
  end

  private



end