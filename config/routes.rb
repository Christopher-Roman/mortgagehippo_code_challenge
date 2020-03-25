Rails.application.routes.draw do


	namespace 'api' do

  		namespace 'v1' do

			post 'coins/:query' => 'coins#create'
			get 'transactions/:query' => 'transactions#index'
			get 'coins/new' => 'coins#new'
			get 'coins/edit/:id' => 'coins#update'
			get 'value' => 'coins#value'

			
			resources :coins

			resources :transactions, only: [:index, :show, :create]
  		end
	end
end
