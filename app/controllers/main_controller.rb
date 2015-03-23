class MainController < ApplicationController

  def index
  	@teams = Team.all
  end

  

end
