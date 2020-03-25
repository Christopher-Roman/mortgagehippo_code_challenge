Rails.application.routes.draw do


	namespace 'api' do

  		namespace 'v1' do
  			#Coin Routes
			post 'coins/:query' => 'coins#create'
			get 'value' => 'coins#value'

			# Transaction custom Route
			get 'transactions/:query' => 'transactions#index'


			resources :admins, only: [:create, :index]
			
			resources :coins

			resources :transactions, only: [:index, :show, :create]
  		end
	end
end
