class Transaction < ApplicationRecord
	validates :coin, presence: true
	validates :created_by, presence: true
end
