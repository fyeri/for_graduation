Rails.application.routes.draw do
  root to: 'owned_items#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
  end

  get "users/profile" => "users#show"
  resources :labels
  resources :owned_items

  resources :wanted_items
  get 'items/by_category', to: 'items#by_category', as: 'items_by_category'
  
  resources :items


  get 'search', to: 'searches#search', as: :search

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end