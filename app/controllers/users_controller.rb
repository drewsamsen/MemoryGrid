class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  
   
  def index
    query = params[:search]
    @users =  Array.new
    params[:friends].each{|f| @users << f if f.downcase.include? query.downcase}
    
  end

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  def link_user_accounts
  if self.current_user.nil?
    #register with fb
    User.create_from_fb_connect(facebook_session.user)
  else
    #connect accounts
    self.current_user.link_fb_connect(facebook_session.user.id) unless self.current_user.fb_user_id == facebook_session.user.id
  end
  #@friends = facebook_session.user.friends!(:name)
  @user = current_user
  @user.last_logged_in = Time.now
  if @user.email.blank?
    @user.email = facebook_session.user.email
  end
  @user.save(false)
  session[:facebook_session] = facebook_session
  redirect_to(root_url)
end

def logout_facebook
    logout_killing_session!
    clear_facebook_session_information
    redirect_to "/login"
  end


end


