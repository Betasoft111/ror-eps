class CompanyRequest < ActiveRecord::Base
	 has_many :users, :foreign_key => :request_by
	 has_many :users, :foreign_key => :request_to
end
