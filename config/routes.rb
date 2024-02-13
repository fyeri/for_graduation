Rails.application.routes.draw do
  resources :labels
  resources :owned_items
  root to: 'owned_items#index'
  resources :wanted_items
  get 'items/by_category', to: 'items#by_category', as: 'items_by_category'
  resources :items


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end