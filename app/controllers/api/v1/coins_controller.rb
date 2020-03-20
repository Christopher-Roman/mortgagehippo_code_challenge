module Api
	module V1
		class CoinsController < ApplicationController
			def index
				coins = Coin.order('created_at DESC')
				render json: {status: 'Success!', message: 'Loaded Coins', data:coins},status: :ok
			end

			def show
				coin = Coin.find(params[:id])
				render json: {status: 'Success!', message: 'Loaded Coin', data:coin},status: :ok
			end

			def create
				coin = Coin.new(coin_params)

				if coin.save
					render json: {status: 'Success!', message: 'Saved Coins', data:coin},status: :ok
				else
					render json: {status: 'Error!', message: 'Coin Not Saved', data:coin.errors},status: :unprocessable_entity
				end
			end

			def destroy
				coin = Coin.find(params[:id])
				coin.destroy

					render json: {status: 'Success!', message: 'Deleted Coin', data:coin},status: :ok
			end

			def update
				coin = Coin.find(params[:id])
				if coin.update_attributes(coin_params)
					render json: {status: 'Success!', message: 'Updated Coin', data:coin},status: :ok
				else
					render json: {status: 'Error!', message: 'Coin Not Updated', data:coin.errors},status: :unprocessable_entity
				end

			end


			private

			def coin_params
				params.permit(:name, :value)
			end
		end
	end
end