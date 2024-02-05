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
    root to: "homes#top"
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
    root to: "homes#top"
    get "/home/about" => "homes#about", as: "about"
    resources :post_images, only: [:new, :create, :index, :show, :destroy] do
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update]
    resources :post_images, only: [:new, :create, :index, :show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
