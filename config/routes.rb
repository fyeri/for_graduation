Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "users/profile" => "users#show"
  resources :labels
  resources :owned_items
  root to: 'owned_items#index'
  resources :wanted_items
  get 'items/by_category', to: 'items#by_category', as: 'items_by_category'
  resources :items

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end