Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
    get '/home/about' => 'homes#about'
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :followers, :following
    end
  end
  resources :relationships, only: [:create, :destroy]
  get '/search', to: 'searchs#search'
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]

end
