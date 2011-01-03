# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  layout 'index'
  before_filter :set_facebook_session
  helper_method :facebook_session
 
  
rescue_from Facebooker::Session::SessionExpired do |exception|
clear_facebook_session_information
clear_fb_cookies!
reset_session # i.e. logout the user
flash[:notice] = "You have been disconnected from Facebook."
# redirect_to :controller => 'memories',:action => 'index'
redirect_to(root_url)
end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
