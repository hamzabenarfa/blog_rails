Rails.application.routes.draw do
  devise_for :users
  
  # /post/1/comments/4
  resources  :posts do
    resources :like, module: :posts
    resources :comments
  end

  get "/:slug", to: "profile#show"
  
  resources  :resources
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?


    
  root "home#index"
end
