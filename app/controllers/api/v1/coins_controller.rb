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

			# Post/Deposit Route for Coins

			def create
				if api_check(params[:query])
					coin = Coin.new(coin_params)
					coin[:name].downcase!
					if coin_name_check(coin[:name])
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
							render json: {status: 'Error!', message: 'Coin Not Saved. ', data:coin.errors},status: :unprocessable_entity
						end
					else
						render json: {status: 'Error!', message: 'The only accepted coins are: Adamentium Coin, Carbonite Coin, Amazonium Coin, or Vibranium Coin'},status: :unprocessable_entity
					end
				else
					render json: {status: 'Error!', message: 'Your API-Key was not accepted. Please use one of the following: Aa11, Bb22, Cc33, or Dd44'},status: :unprocessable_entity
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
						render json: {status: 'Error!', message: 'Transaction Not Saved. Ensure coin creation JSON object includes transaction_type.', data:transaction.errors},status: :unprocessable_entity
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
			end


			def inventory_check
				adamentium = Coin.where("name = 'adamentium coin'")
				carbonite = Coin.where("name = 'carbonite coin'")
				amazonium = Coin.where("name = 'amazonium coin'")
				vibranium = Coin.where("name = 'vibranium coin'")

				all_coins = [
							{type: "Adamentium Coins", number: adamentium.count}, 
							{type: "Carbonite Coins", number: carbonite.count},
							{type: "Amazonium Coins", number: amazonium.count},
							{type: "Vibranium Coins", number: vibranium.count}
							]

				all_coins.each do |coin|
					if coin[:number] < 4
						total_value = value
						AdminAlertMailer.coins_low(coin, total_value).deliver
					end
				end
			end

			private

			def api_check(str)
				accepted_keys = ["Aa11", "Bb22", "Cc33", "Dd44"]
				accepted_keys.include?(str)
			end

			def coin_name_check(str)
				accepted_names = ["adamentium coin", "carbonite coin", "amazonium coin", "vibranium coin"]
				accepted_names.include?(str)
			end


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