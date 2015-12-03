class CompanyStaff < ActiveRecord::Base
	belongs_to :user, :foreign_key => :company_id
	has_attached_file :image
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
	#has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
end