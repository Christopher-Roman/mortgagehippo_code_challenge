class Coin < ApplicationRecord
	has_one :transaction
	validates :name, presence: true
	validates :value, presence: true
end
