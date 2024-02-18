Rails.application.routes.draw do

  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end

  scope module: :public do
    root to: "homes#top"
    get "/home/about" => "homes#about", as: "about"
    get "search", to: "searches#search"
    resources :post_images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update, :index, :destroy] do
      member do
      get :favorites
      end
    end
    resources :post_images, only: [:new, :create, :index, :show, :destroy]
  end
  
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
