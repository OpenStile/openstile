class RetailerInterest < ActiveRecord::Base

	validates :boutique_name, presence: true 
	validates :first_name
	validates :last_name, presence: true
	validates :street_address, presence: true
	validates :city, :state, presence: true
	validates :zip_code, presence: true
	validates :email_address, presence: true
	validates :phone_number, presence: true
	validates :website_address, presence: true
	validates :describe_store_aesthetic, presence: true

end
