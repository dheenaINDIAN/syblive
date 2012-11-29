class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def dashboard
	  @current_user = current_user.firstname
    #@current_user_profile = current_user.user_profiles
  end

  def new_user_profile
    @user_profile = UserProfile.new
  end
  
  def create_user_profile
    #@user_profile = UserProfile.new(params[:user_profile])
   # if @user_profile.valid?
     # @user_profile.user_id = current_user.id
     # @user_profile.save
     # flash[:notice] = 'UserProfile was created successfully.'
      #redirect_to home_dashboard_path
    #else
      #render :action=>'new_user_profile'
   # end
  end
  
end
