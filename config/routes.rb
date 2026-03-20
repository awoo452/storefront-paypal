Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resource :cart, only: [ :show ] do
    post "items", to: "carts#add_item", as: :items
    delete "items/:variant_id", to: "carts#remove_item", as: :item
  end

  resources :products, only: [ :index, :show ]

  post "/paypal/orders", to: "paypal#orders"
  post "/paypal/orders/:id/capture", to: "paypal#capture"

  namespace :admin do
    root to: "dashboard#index"
    resources :orders, only: [ :index, :show ]
    resources :product_variants, only: [ :new, :create, :edit, :update ]
    resources :products, only: [ :index, :new, :create, :edit, :update, :destroy ]
    resources :vendors, only: [ :index, :new, :create, :edit, :update, :destroy ]
    resources :vendor_products, only: [ :index, :new, :create, :edit, :update, :destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
