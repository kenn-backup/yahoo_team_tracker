class UsersController < ApplicationController

	def show
	  @user = User.find(params[:id])
	end

	def edit
	  @user = User.find(params[:id])
	end

	def delete
	  @user = User.find(params[:id])
	end

	def new
	  @user = User.new
	end

	def create
	  @user = User.new(user_params)
	  @user.save
	  if @user.save
	  	session[:id] = @user.id
	  	redirect_to "/users/#{@user.id}" 
	  else
	  	render :new
	  end
	end	

	def update
	  User.find_by_id(params[:id]).update_attributes(user_params)
	  redirect_to user_path
	end

	private

	def user_params
	  params.require(:user).permit(:username, :email, :password)
	end

end
