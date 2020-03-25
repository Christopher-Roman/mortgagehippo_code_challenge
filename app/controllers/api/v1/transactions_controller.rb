module Api

	module V1

		class TransactionsController < ApplicationController

			# Get Route for all Transactions
			def index
				if params[:query]
					transactions = Transaction.where(api_key: params[:query])
					render json: {status: 'Success!', data:transactions},status: :ok
				else
					transactions = Transaction.all()
					render json: {status: 'Success!', data:transactions},status: :ok
				end
			end

		end

	end
end