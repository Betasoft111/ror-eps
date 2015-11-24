class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :authenticate_user!

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if @current_user != nil
      @current_user
    else
      redirect_to '/join', :notice => 'Please login to view this'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def check_admin
    if admin_id != '' && user_role && user_role == 'admin' && user_role != nil
    else
      redirect_to '/admin/log_in'
    end
  end

end
