require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    if User.find_by(params)
      session[:user_id] = User.find_by(params).id
      redirect to "/account"
    else
      erb :error
    end
  end

  get '/account' do
    @session = session
    if Helpers.is_logged_in?(@session)
      erb :account
    else
      erb :error
    end
  end

  get '/logout' do
    session.clear
    redirect to "/"
  end

end