class Admin::AdminController < ApplicationController
	before_filter :check_admin!, only: [:edit_company, :edit_page]

	#################################
	#  	       Render Index Page    #
	#################################
	def index
		admin_id = session[:user_id]
		user_role = session[:user_role]

		if admin_id != '' && user_role && user_role == 'admin' && user_role != nil
			#################################
			#  Get The List Of Comapnies    #
			#################################
			@companies = User.all.order('id DESC')
		else
			redirect_to '/admin/log_in'
		end
	end

	#################################
	#  	   Show Selected Company    #
	#################################
	def edit_company
		@company = User.find(params[:id]) 
	end


	def update

		User.where(:id => params[:id]).update_all(first_name: params[:first_name], last_name: params[:last_name], email: params[:email],user_type: params[:user_type])
		redirect_to '/admin' , :notice => "Record Updated!"

	end

	def delete 
		 User.find(params[:id]).destroy
		redirect_to '/admin' , :notice => "Record Deleted!"
	end


	def user_activiy
		@user_act =  User.all.order('id DESC')
	end


	#################################
	#  Create Demo Login For Admin  #
	#################################
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

	#################################
	#         Login For Admin       #
	#################################
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

	###############################
	#  Get The List General Page  #
	###############################
	def pages
		@pages = Admin::GeneralPages.all
	end

	#######################################
	#  Edit The Content Of General Pages  #
	#######################################
	def edit_page
		@page_details = Admin::GeneralPages.where(:page_name => params[:page_name]).first
	end

	########################################
	#  Update The Content Of General Pages #
	########################################
	def update_page
		Admin::GeneralPages.where(:id => params[:id]).update_all(page_params)
		redirect_to "/admin/pages", :notice => "Page details has been updated"
	end

	##############################
	#          Logout Admin      #
	##############################
	def destroy
		session[:user_id] = nil
		session[:user_role] = nil
	  	redirect_to "/admin", :notice => "Logged out!"
	end

	###################
	#    Add Company  #
	###################
	def add_user		
	end

	##########################
	#    Create New Copmany  #
	##########################
	def create_company		
		@user = User.new({:first_name => params[:first_name],
						  :last_name => params[:last_name],
						  :email => params[:email],
						  :user_type => params[:user_type],
						  :password => params[:password]
						})
		  if @user.save
		    redirect_to "/admin", :notice => "New Company is added"
		  else
		  	@errorMsg = ''
		  	@user.errors.each do |key, message|
		  		@errorMsg += key.to_s
		  		@errorMsg += ' '
		  		@errorMsg += message.to_s
		  	end
		    redirect_to "/admin/add_company", :notice => @errorMsg # "Please fill all details"
		  end
	end

	private

	 def plan_params
	    params.permit(:first_name, :last_name, :email, :user_type)
	 end

	 def page_params
	    params.permit(:page_name, :page_title, :page_content)
	 end
end
