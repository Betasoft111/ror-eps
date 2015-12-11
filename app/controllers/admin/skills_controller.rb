class Admin::SkillsController < ApplicationController
	before_filter :check_admin!

	#for list skills section


	def index
			@all_skills = AdminSkills.all
	end



	#to load  add new skill page
	def new
		
	end

	#function to add new skill
	def add
		@added_skill = AdminSkills.new(skill_params)
		if @added_skill.save
			redirect_to "/admin/skills", :notice => "New Skill is added successfully!!!"
		else
			redirect_to "/admin/skills/new", :notice => @subscription_plan.errors
		end
	end

	def edit
		@Editedskill = AdminSkills.find(params[:id])
	end

	def update
		AdminSkills.where(:id => params[:skillid]).update_all(skill: params[:skill])
		redirect_to "/admin/skills", :notice => "Skill updated successfully!!!"
	end

	def delete
	    AdminSkills.find(params[:id]).destroy
	    redirect_to "/admin/skills", :notice => "Record Deleted successfully!!!"
	end








	private

	  def skill_params
	    	params.permit(:skill)
	  end
end
