class Transaction < ApplicationRecord
	belongs_to :coin
	validates :name, presence: true
	validates :value, presence: true
end
