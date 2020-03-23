module Api
	module V1
		class TransactionsController < ApplicationController

			# Get Route for all Transactions
			def index
				transactions = Transaction.all
				render json: {status: 'Success!', message: 'Loaded Transactions', data:transactions},status: :ok
			end
		end
	end
end
