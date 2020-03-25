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
				render json: {status: 'Success!', message: 'Loaded Coin', data:coin.render_to_string('index.html')},status: :ok
			end

			def new
				render file: Rails.root.join('public', 'new')
			end

			# Post/Deposit Route for Coins

			def create
				if (params[:query] == "food" || params[:query] == "bills" || params[:query] == "fun" || params[:query] == "savings")
					coin = Coin.new(coin_params)
					if(coin[:name] == "Adamentium Coin" || coin[:name] == "Carbonite Coin" || coin[:name] == "Amazonium Coin" || coin[:name] == "Vibranium Coin")
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
						render json: {status: 'Error!', message: 'Must be one of the following coin names: Adamentium Coin, Carbonite Coin, Amazonium Coin, or Vibranium Coin'},status: :unprocessable_entity
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
						if coin.destroy
							coins = Coin.order('created_at DESC')
							@check = inventory_check

							render json: {status: 'Success!', message: 'Deleted Coin', data:@check},status: :ok
						end
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

			def value
				coins = Coin.sum('value')
				render json: {status: 'Success!', message: 'Total has been calculated', data:coin},status: :ok
			end


			def inventory_check
				adamentium = Coin.where("name = 'Adamentium Coin'").count
				carbonite = Coin.where("name = 'Carbonite Coin'").count
				amazonium = Coin.where("name = 'Amazonium Coin'").count
				vibranium = Coin.where("name = 'Vibranium Coin'").count

				all_coins = [adamentium, carbonite, amazonium, vibranium]

				all_coins.each do |coins|
					if coins < 4
						#email function goes here
						return "Inventory low, email sent."
					end
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