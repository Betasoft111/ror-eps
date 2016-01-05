class Admin::AdminMessagesController < ApplicationController

	def index
		@userdata = User.find(params[:id])
	end

	def send_message
		@user = Messages.new(plan_params)
		 if @user.save
		    redirect_to "/admin", :notice => "Message Sent Successfully !!!"
		end
	end







	private

	 def plan_params
	    params.permit(:message_to, :message_subject, :message_data)
	 end

end
