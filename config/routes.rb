Rails.application.routes.draw do
  devise_for :users
  resources :posts
  resources :resources

    
  root "home#index"
end
