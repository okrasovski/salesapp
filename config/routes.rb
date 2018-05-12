Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root :to => 'welcome#index'
	root 'welcome#index'
	#get '/salesapp' => 'welcome#index', :as => :root
	#get '/products' => 'products#index'
	
	resources :products
	resources :users, only: [:index]
	resources :sources #, only: [:index]
	resources :sales
	resources :clients
   
end
