Rails.application.routes.draw do

  namespace 'api' do

  	namespace 'v1' do

  		resources :coins, only: [:index, :show, :create, :update, :destroy,] do

  			resources :transactions, only: [:index, :show, :create]

  		end

  	end

  end

end
