class SessionController < ApplicationController

  def index
    redirect_to :action => "login"
  end

  def authenticate
    session[:user_id] = nil
    if request.post?
      if params[:name] == "jfoster" && params[:password] == "12345"
        session[:user_id] = "jfoster"
        redirect_to_stored
      else
        flash[:notice] = "Invalid username or password"
        redirect_to :action => "login"
      end
    end
  end
  
  def login
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to :back
#    redirect_to :action => "login"
  end
end