class SubscriptionPlans < ActiveRecord::Base
	has_many :users, dependent: :delete_all

	validates_presence_of :plan_name
  	validates_presence_of :plan_price

end
