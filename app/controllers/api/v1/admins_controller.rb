module Api

	module V1

		class AdminsController < ApplicationController

			# Get Route for all Admins
			def index
				admins = Admin.all()
				render json: {status: 'Success!', data:admins},status: :ok
			end

			def create
				admin = Admin.new(admin_params)
				if admin.save
					render json: {status: 'Success!', message: 'Admin Created', data:admin},status: :ok
				end
			end


			private

			def admin_params
				params.permit(:email)
			end

		end

	end
end