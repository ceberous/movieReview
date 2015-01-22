Rails.application.routes.draw do
  
  root 'movies#index'

  devise_for :users
  
  resources :movies do
  	collection do
  		get 'search'
  	end
  	resources :reviews , except: [:show , :index]
  	put :remove_photo , :on => :collection
  end

end
