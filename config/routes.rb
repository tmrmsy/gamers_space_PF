Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  namespace :public do
    resources :posts, only: [:new, :index, :show, :edit]
  end
  namespace :public do
    resources :users, only: [:show, :edit]
    get 'users/withdrawal'
  end
  namespace :public do
    root to: 'homes#top'
    get 'homes/about'
  end

  namespace :admin do
    resources :users, only: [:show, :edit, :update]
  end

  namespace :admin do
    resources :posts, only: [:index, :show, :edit]
  end

  namespace :admin do
    root to: 'homes#top'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
