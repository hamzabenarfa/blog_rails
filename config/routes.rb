Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # /post/1/comments/4
  resources  :posts do
    resources :comments
  end
  resources  :resources
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?


    
  root "home#index"
end
