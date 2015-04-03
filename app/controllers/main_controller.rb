class MainController < ApplicationController

  def index
  	@teams = Team.all.order(score: :desc)
  end

end
