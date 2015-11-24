class Admin::AdminController < ApplicationController
#	before_filter :check_admin!#, except: :create
	#skip_before_filter :login
	def index
		admin_id = session[:user_id]
		user_role = session[:user_role]

		if admin_id != '' && user_role && user_role == 'admin' && user_role != nil
		else
			redirect_to '/admin/log_in'
		end
	end

	def create
		@new_admin = Admin::AdminUser.create!({
          :email=>'epsadmin@admin.com',
          :password=>'Admin123#',
          :first_name=>'Jogen',
          :last_name=>'Maltesen',
        });
        if @new_admin.id != nil
        	return render :json => {:success => "true", :message => @new_admin }
        else
        	return render :json => {:success => "false", :message => @new_admin.errors }
        end
	end

	def login
		@admin = Admin::AdminUser.new	
	end

	def do_login
	admin = Admin::AdminUser.authenticate(params[:email], params[:password])
	  if admin
	    session[:user_id] = admin.id
	    session[:user_role] = 'admin'
	    redirect_to '/admin', :notice => "Logged in!"
	  else
	    #flash.now.alert = "Invalid email or password"
	    redirect_to "/admin/log_in", :notice => "Invalid email or password"
	  end
	end

	def destroy
		session[:user_id] = nil
		session[:user_role] = nil
	  	redirect_to "/admin", :notice => "Logged out!"
	end
end
