class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :authenticate_user!
  #before_filter :authenticate_user!
  private

  #################################
  #        Set Current User       #
  #################################
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  #################################
  #        Check User Login       #
  #################################
  def authenticate_user!
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @faqs = Admin::HelpCenter.order('id desc')
    if @current_user != nil
      @current_user
    else
      redirect_to '/sign_in', :notice => 'Please login to view this'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  #################################
  #        Check current plan     #
  #################################
  def check_membership
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
      if @current_user != nil           
        if @current_user.plan_id != nil
        else
          redirect_to "/membership_plans", :notice => "Please choose a membership plan"
        end
      end
  end 

  #################################
  #        Check Is Admin         #
  #################################
  def check_admin!
    if session[:user_id] != '' && session[:user_role
      ] && session[:user_role] == 'admin' && session[:user_role] != nil
    else
      redirect_to '/admin/log_in'
    end
  end

end
