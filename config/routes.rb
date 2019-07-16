Rails.application.routes.draw do
  resources :reservations
  resources :faculties
  resources :students
  resources :users do
    get '/users_checkout_items', to: 'users#checkout_items', as: 'checkout_items'
    post '/users_checkout/:library_item_id', to: 'users#checkout', as: 'checkout'
    post '/users_return/:library_item_id', to: 'users#return', as: 'return'
  end
  resources :books
  resources :conference_proceedings
  resources :journals
  resources :library_items
  resources :magazines
  post '/users_login', to: 'users#login', as: 'login'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
