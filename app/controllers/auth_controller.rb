class AuthController < ApplicationController

  def login
  	@user = User.new
  end

  def signin
    user = User.find_by(username: params[:user][:username])
    if user.password == params[:user][:password]
  	  session[:id] = user.id
  	  redirect_to "/users/#{user.id}"
    else
  	  redirect_to '/login'
    end
  end

  def logout
	session.clear
	redirect_to '/'
  end

end
