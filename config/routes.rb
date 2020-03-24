Rails.application.routes.draw do


	namespace 'api' do

  		namespace 'v1' do

			post 'coins/:query' => 'coins#create'
			
			resources :coins, only: [:index, :show, :create, :update, :destroy]

			resources :transactions, only: [:index, :show, :create]
  		end
	end
end
