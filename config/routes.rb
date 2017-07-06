Rails.application.routes.draw do
  get 'profiles/index'

  get 'profiles/show'

  devise_for :users
  resources :tweets
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
