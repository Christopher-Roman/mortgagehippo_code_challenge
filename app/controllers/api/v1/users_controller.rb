module Api
	module V1
		class UsersController < ApplicationController

			# Get Route for all Users
			def index
				users = User.all
				render json: {status: 'Success!', message: 'Loaded Users', data:users},status: :ok
			end

			def create
				user = User.new(user_params)
				if user.save
					render json: {status: 'Success!', message: 'User Created!', data:user},status: :ok
				else
					render json: {status: 'Error!', message: 'Something went wrong.', data:user.errors},status: :unprocessable_entity
				end
			end

			private

			# User object keys to verify before creating a user

			def user_params
				params.permit(:username, :email, :admin)
			end

		end
	end
end