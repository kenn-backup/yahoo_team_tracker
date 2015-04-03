class AuthController < ApplicationController

  def login
  	@user = User.new
  end

  def signin
    # user = User.find_by(username: params[:user][:username])
    # if user.password == params[:user][:password]
  	 #  session[:id] = user.id
  	 #  redirect_to "/users/#{user.id}"
    # else
  	 #  redirect_to '/login'
    # end

    auth = {}

    auth[:consumer_key] = "dj0yJmk9dERQWE52SWZwMFpOJmQ9WVdrOVZtUm5kME5QTm5FbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD1hMg--"

    auth[:consumer_secret] = "98e16121caf42e9bc410748a6638ab6da59d3a4f"

    @@consumer = OAuth::Consumer.new(auth[:consumer_key], auth[:consumer_secret], 
      {
        :site                 =>"https://api.login.yahoo.com", 
        :scheme               => :query_string, 
        :http_method          => :get,
        :request_token_path   => '/oauth/v2/get_request_token', 
        :access_token_path    => '/oauth/v2/get_token',
        :authorize_path       => '/oauth/v2/request_auth'
      })

    @@request_token = @@consumer.get_request_token( { :oauth_callback => 'http://localhost:3000/callback' } )

    p "*"*50
    p @@request_token
    p "*"*50

    redirect_to @@request_token.authorize_url

  end

  def callback
    request_token = ActiveSupport::JSON.decode(@@request_token.to_json)

      # if !(request_token.present?)
      #   $request_token_value = "Response failed"  
      # else
      #   $request_token_value = request_token  
      # end

      @@access_token = @@request_token.get_access_token(:oauth_verifier=>params[:oauth_verifier]) 
      access_json = ActiveSupport::JSON.decode(@@access_token.to_json)

      session[:access_token] = access_json["token"]
      session[:access_secret] = access_json["params"]["oauth_token_secret"]
      puts "****************************" 
      puts access_json
      puts "****************************"

      session[:id] = 4

      redirect_to root_path

  end

  def signup
    user = User.new(params[:new_user])
    user.save

    if user.save
      session[:id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def logout
  	session.clear
  	redirect_to '/'
  end

end
