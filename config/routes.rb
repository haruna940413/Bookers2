Rails.application.routes.draw do

  devise_for :users
  
  get 'search' => 'search#search'


  resources :users do
   resources :relationships, only: [:create, :destroy, ]
  end

  resources :books do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
 end

  root to: 'home#top'
  get "home/about" => 'home#about'
  get "following_user/:id" => "relationships#index_following_user", as: "following_user"
  get "follower_user/:id" => "relationships#index_follower_user", as: "follower_user"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
