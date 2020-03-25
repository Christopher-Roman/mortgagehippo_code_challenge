class Admin < ApplicationRecord
	validates :email, presence: true
end
