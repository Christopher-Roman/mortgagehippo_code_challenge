class Coin < ApplicationRecord
	after_create do
		Transaction.create coin: self
	end
	has_one :owner, foreign_key: "transaction_id", class_name: "Transaction"
		accepts_nested_attributes_for :owner
	validates :name, presence: true
	validates :value, presence: true
end

class Transaction < ApplicationRecord
	belongs_to :coin
	validates :name, presence: true
	validates :value, presence: true
end
