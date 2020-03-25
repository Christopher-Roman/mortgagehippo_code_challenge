module Api

	module V1

		class TransactionsController < ApplicationController

			# Get Route for all Transactions
			def index
				if params[:query]
					transactions = Transaction.where(api_key: params[:query])
					render 'index'
				else
					transactions = Transaction.order('created_at DESC')
					render 'index'
				end

			end

		end

	end
end