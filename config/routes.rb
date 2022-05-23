Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    resources :posts
  end
  scope module: :public do
    resources :users, only: [:show, :edit, :update, :destroy]
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
  end

  namespace :admin do
    resources :users, only: [:show, :edit, :update]
  end

  namespace :admin do
    resources :posts, only: [:index, :show, :edit, :destroy]
  end

  namespace :admin do
    root to: 'homes#top'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
