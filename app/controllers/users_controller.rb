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
	    redirect_to "/join", :notice => "Please fill all details"
	  end
	end

	def forgot_password
	end

	def request_password
		@user = User.find_by_email(params[:email])
		if @user == nil || @user == ''
			redirect_to "/forgot_password", :notice => "Please enter a valid email"
		else
			@random_string = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
			@url  = root_url + 'reset_password/' + @random_string
    		User.where('id': @user.id).update_all(reset_password_token: @random_string)
			@email = UserMailer.forgot_password(@user, @url).deliver
			redirect_to "/forgot_password", :notice => "Please check your email to reset your password"
	    end
	end

	def reset_password
		@user = User.where(:reset_password_token => params[:reset_password_token])
		if @user.empty?
			redirect_to "/invalid_password_token", :notice => "Invalid password token"
		else
			@token = params[:reset_password_token]
		end
	end

	def update_password
		password_salt = BCrypt::Engine.generate_salt
        password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
		@user = User.where('reset_password_token': params[:reset_password_token]).update_all(password_hash: password_hash, password_salt: password_salt)
		puts 'finded'
		puts @user
		redirect_to "/join", :notice => "Your password has been changed, please login"
	end

	def invalid_password_token
		
	end

	def choose_plan
	end

	private

	  def user_params
	    params.require(:user).permit(:first_name, :last_name, :email, :password, :plan_id, :user_type, :password_confirmation)
	  end
end
