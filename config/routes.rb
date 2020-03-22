Rails.application.routes.draw do

  namespace 'api' do

  	namespace 'v1' do

  		resources :users, only: [:create, :destroy] do

  			resources :coins, only: [:index, :show, :create, :update, :destroy,]

  				resources :transactions, only: [:index, :show, :create]

  		end

  	end

  end

end
