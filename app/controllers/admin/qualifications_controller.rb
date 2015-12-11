class Admin::QualificationsController < ApplicationController
		before_filter :check_admin!


		def index
			@all_qualification = AdminQualifications.all
		end

		def new

		end

		def add
			@added_skill = AdminQualifications.new(qualification_params)
			if @added_skill.save
				redirect_to "/admin/qualifications", :notice => "New qualification is added successfully!!!"
			else
				redirect_to "/admin/qualifications/new", :notice => @subscription_plan.errors
			end
		end

		def edit
			@Editedskill = AdminQualifications.find(params[:id])
		end

		def update
			AdminQualifications.where(:id => params[:skillid]).update_all(qualification: params[:qualification])
			redirect_to "/admin/qualifications", :notice => "Qualification updated successfully!!!"
		end

		def delete
	    AdminQualifications.find(params[:id]).destroy
	   		 redirect_to "/admin/qualifications", :notice => "Record Deleted successfully!!!"
		end




		
private

	  def qualification_params
	    	params.permit(:qualification)
	  end


end
