module Api

	module V1

		class TransactionsController < ApplicationController

			# Get Route for all Transactions
			def index
				if params[:query]
					transactions = Transaction.find_by(api_key: params[:query])
					render json: {status: 'Success!', message: 'Loaded All Transactions', data:transactions},status: :ok
				else
					transactions = Transaction.order('created_at DESC')
					render json: {status: 'Success!', message: 'Loaded All Transactions', data:transactions},status: :ok
				end
			end

		end

	end
end