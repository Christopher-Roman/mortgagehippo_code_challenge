class Transaction < ApplicationRecord
	belongs_to :coin
	validates :coin, presence: true
	validates :created_by, presence: true
end
