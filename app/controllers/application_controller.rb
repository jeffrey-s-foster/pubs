class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery

  def login_required
    return true if session['cas'] && (session['cas']['user'] == 'jfoster4')
    if session['cas']
      # logged in but invalid user
      render :file => "public/baduser.html"
      return
    end
    render :file => "public/401.html", :status => :unauthorized # not logged in
    # if session[:user_id]
    #   return true
    # end
    # flash[:notice] = 'Please log in to continue'
    # session[:return_to] = request.request_uri
    # redirect_to :controller => "session", :action => "login"
    # return false
  end

  # def redirect_to_stored
  #   if return_to = session[:return_to]
  #     session[:return_to] = nil
  #     redirect_to return_to
  #   else
  #     redirect_to :controller => 'papers', :action => 'index'
  #   end
  # end
end
