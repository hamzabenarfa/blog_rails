Rails.application.routes.draw do
  devise_for :users
  resources  :posts
  resources  :resources
  resources  :profile

    
  root "home#index"
end
