class SubscriptionPlans < ActiveRecord::Base
	has_many :users, dependent: :delete_all
end
