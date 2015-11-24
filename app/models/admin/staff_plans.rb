class Admin::StaffPlans < ActiveRecord::Base
	validates_presence_of :plan_name
  	validates_presence_of :no_of_staff
  	validates_presence_of :plan_price

	
end
