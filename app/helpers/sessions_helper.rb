module SessionsHelper

	def display_error(field)
    	if @user.errors[field].any?
        	raw field.to_s.capitalize+" "+@user.errors[field].first
    	end
	end
end