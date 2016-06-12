class AdminController < ApplicationController

	before_filter :login_required

	def index
    render :layout => 'login_bar'
	end
end