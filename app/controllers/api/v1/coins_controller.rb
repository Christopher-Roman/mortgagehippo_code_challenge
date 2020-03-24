module Api
	module V1
		class CoinsController < ApplicationController

			# Get Route for all Coins
			def index
				coins = Coin.order('created_at DESC')
				render json: {status: 'Success!', message: 'Loaded Coins', data:coins},status: :ok
			end

			# Get Route for specific Coin

			def show
				coin = Coin.find(params[:id])
				render json: {status: 'Success!', message: 'Loaded Coin', data:coin},status: :ok
			end

			# Post/Deposit Route for Coins

			def create
				if (params[:query] == "food" || params[:query] == "bills" || params[:query] == "fun" || params[:query] == "savings")
					coin = Coin.new(coin_params)
					coin[:api_key] = params[:query]
					if coin.save
						transaction = Transaction.new(transaction_params)
						transaction[:api_key] = params[:query]
						if transaction.save
							render json: {status: 'Success!', message: 'Saved Coins', data:coin},status: :ok
						else
							render json: {status: 'Error!', message: 'Transaction Not Saved', data:transaction.errors},status: :unprocessable_entity
						end
					else
						render json: {status: 'Error!', message: 'Coin Not Saved', data:coin.errors},status: :unprocessable_entity
					end
				else
					render json: {status: 'Error!', message: 'Incorrect API Key', data:coin.errors},status: :unprocessable_entity
				end
			end

			# Delete/withdrawal Route for Coins

			def destroy
				coin = Coin.find(params[:id])
				if coin.save
					transaction = Transaction.new(name: coin.name, value:coin.value, api_key: coin.api_key, transaction_type: "Withdrawal")
					if transaction.save
						coin.destroy
						render json: {status: 'Success!', message: 'Deleted Coin', data:coin},status: :ok
					else
						render json: {status: 'Error!', message: 'Transaction Not Saved', data:transaction.errors},status: :unprocessable_entity
					end
				else
					render json: {status: 'Error!', message: 'Something went wrong.', data:coin.errors},status: :unprocessable_entity	
				end
			end

			# Put Route for Coins

			def update
				coin = Coin.find(params[:id])
				if coin.update_attributes(coin_params)
					render json: {status: 'Success!', message: 'Updated Coin', data:coin},status: :ok
				else
					render json: {status: 'Error!', message: 'Coin Not Updated', data:coin.errors},status: :unprocessable_entity
				end

			end


			private
			# transaction object keys to verify before creating/editing coins

			def transaction_params
				params.permit(:name, :value, :api_key, :transaction_type)
			end

			# Coin object keys to verify before creating/editing coins

			def coin_params
				params.permit(:name, :value, :api_key)
			end
		end
	end
end