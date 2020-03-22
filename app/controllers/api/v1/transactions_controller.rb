module Api
	module V1
		class TransactionsController < ApplicationController

			# Get Route for all Transactions
			def index
				transactions = Transaction.all
				render json: {status: 'Success!', message: 'Loaded Transactions', data:transactions},status: :ok
			end

			def create
				transaction = Transaction.new(transaction_params)
				if transaction.save
					render json: {status: 'Success!', message: 'Saved Transaction', data:transaction},status: :ok
				else
					render json: {status: 'Error!', message: 'Transaction Not Saved', data:transaction.errors},status: :unprocessable_entity
				end
			end
			# transaction object keys to verify before creating/editing coins

			def transaction_params
				params.permit(:name, :value, :coin_id)
			end
		end
	end
end
