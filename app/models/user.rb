class User < ApplicationRecord
	validates :username, presence: true
	validates :email, presence: true

	has_many :owner, foreign_key: "user_id", class_name: "Transaction"
	has_many :coin

	before_create do |user|
    	user.api_key = user.generate_api_key
  	end

  # Generate a unique user API key
	def generate_api_key
    	loop do
      		token = SecureRandom.base64.tr('+/=', 'Qrt')
      		break token unless User.exists?(api_key: token)
    	end
  	end
end
