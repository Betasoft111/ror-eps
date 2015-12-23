class SubscriptionPlan < ActiveRecord::Base
	#attr_accessible :plan_name, :plan_price, :plan_type
	has_many :users, dependent: :delete_all
	has_one :user, :foreign_key => :plan_id
	validates_presence_of :plan_name
  	validates_presence_of :plan_price
  	validates_presence_of :plan_type

end
