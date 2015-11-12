class UsersController < ApplicationController
	#skip_before_action :new, :create
	#before_filter :authenticate_user!
	
	def new
	  @user = User.new
	end

	def create
	  @user = User.new(user_params)
	  if @user.save
	    session[:user_id] = @user.id
	    redirect_to "/", :notice => "Signed up!"
	  else
	    render "new"
	  end
	end

	def forgot_password
	end

	def request_password
		@user = User.find_by_email(params[:email])
		if @user == nil || @user == ''
			redirect_to "/forgot_password", :notice => "Please enter a valid email"
		else
			@link = Time.now.getutc.to_time.iso8601
			User.where('id': @user.id).update_all(reset_password_token: @link)
			@email = UserMailer.welcome_email(@user).deliver
	    end
	end

	private

	  def user_params
	    params.require(:user).permit(:first_name, :last_name, :email, :password, :plan_id, :user_type, :password_confirmation)
	  end
end
