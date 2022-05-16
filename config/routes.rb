Rails.application.routes.draw do
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/withdrawal'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :admin do
    resources :users, only: [:show, :edit, :update]
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  #devise_for :users
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
