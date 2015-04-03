class TeamsController < ApplicationController

  # Include check to see if user is logged in before any actions are completed

  skip_before_filter :verify_authenticity_token

  def show
  	@team = Team.find(params[:id])
  end

  def edit
    @team = Team.find(params[:id])
  end

  def new

    auth = {}

    auth[:consumer_key] = "dj0yJmk9dERQWE52SWZwMFpOJmQ9WVdrOVZtUm5kME5QTm5FbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD1hMg--"

    auth[:consumer_secret] = "98e16121caf42e9bc410748a6638ab6da59d3a4f"

    if session[:id]
      @team = Team.new
    	@players = Player.all.order(last_name: :asc)

      url = "http://fantasysports.yahooapis.com/fantasy/v2/users;use_login=1/games;game_keys=mlb/teams"
      parameters = "format=json&oauth_consumer_key=#{auth[:consumer_key]}&oauth_nonce=#{SecureRandom.hex}&oauth_signature_method=HMAC-SHA1&oauth_timestamp=#{Time.now.to_i}&oauth_token=#{session[:access_token]}&oauth_version=1.0&realm=yahooapis.com"
      base_string = 'GET&' + CGI.escape(url) + '&' + CGI.escape(parameters)
      secret = "#{auth[:consumer_secret]}&#{session[:access_secret]}"
      oauth_signature = CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1', secret, base_string)}").chomp)
      api_url = url + '?' + parameters + '&oauth_signature=' + oauth_signature

      user_teams_json = HTTParty.get(api_url)

      user_teams = ActiveSupport::JSON.decode(user_teams_json.to_json)

      p "*"*20
      p api_url
      p "*"*20

      p "*"*40
      p user_teams
      p "*"*40

    else
      redirect_to "/login"
    end
  end

  def update
    updated_info = update_params.delete_if { |key, value| value == "" || value == nil }

    Team.find_by_id(params[:id]).update_attributes(updated_info)

    redirect_to user_path(session[:id])
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

    new_player_count = params[:player_count].to_i + 1

    respond_to do |format|
      format.html { render partial: 'players/add_player', locals: {players: Player.all.order(last_name: :asc), num_players: new_player_count } }
    end
  end

  def vote
    if session[:id]
      team = Team.find_by_id(params[:id])
      team.score += 1
      team.save

      return_obj = {team_id: params[:id], score: team.score}
      render json: return_obj
    else
      404
    end

  end

  private

    def update_params
      params.require(:edit_team).permit(:name, :username)
    end

end