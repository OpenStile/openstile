class RetailerInterest < ActiveRecord::Base

      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/

	validates :boutique_name, presence: true, length: { maximum: 50 }
	validates :email_address, presence: true, length: { maximum: 100 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
	validates :first_name, length: { maximum: 50 }
	validates :last_name, length: { maximum: 50 }
	validates :street_address, length: { maximum: 9 }
	validates :city, :state, length: { maximum: 25 }
	validates :zip_code, length: { maximum: 9 }
	validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX, message: "must be 10 or 11 numeric digits." }, 
                         unless: "phone_number.nil? or phone_number.empty?"
end
