Rails.application.routes.draw do
  resources :labels
  resources :owned_items
  root to: 'owned_items#index'
  resources :wanted_items
  resources :items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
