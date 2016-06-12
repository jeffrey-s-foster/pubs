class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include ApplicationHelper
  protect_from_forgery

  def login_required
    return true if logged_in
    if session['cas']
      # logged in but invalid user
      render :file => "public/baduser.html"
      return
    end
    render :file => "public/401.html", :status => :unauthorized # not logged in
  end
end
