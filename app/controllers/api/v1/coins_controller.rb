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
				coin = Coin.new(coin_params)
				if coin.save
					transaction = Transaction.new(name: coin.name, value: coin.value, coin_id: coin.id)
					if transaction.save
						render json: {status: 'Success!', message: 'Saved Coins', data:coin},status: :ok
					else
						render json: {status: 'Error!', message: 'Coin Not Saved', data:coin.errors},status: :unprocessable_entity
					end
				end
			end

			# Delete/withdrawal Route for Coins

			def destroy
				coin = Coin.find(params[:id])
				transaction = Transaction.new(name: coin.name, value:coin.value)
				coin.destroy

					render json: {status: 'Success!', message: 'Deleted Coin', data:coin},status: :ok
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


			private

			# Coin object keys to verify before creating/editing coins

			def coin_params
				params.permit(:name, :value)
			end
		end
	end
end