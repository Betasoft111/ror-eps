class Admin::HelpCenter < ActiveRecord::Base
	validates_presence_of :question
	validates_presence_of :answer
end
