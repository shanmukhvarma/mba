class Outbox < ActiveRecord::Base
	
	validates :name, format: /@/
end
