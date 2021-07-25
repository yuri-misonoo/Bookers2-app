Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
    get '/home/about' => 'homes#about'
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
  delete '/books/:id' => 'books#destroy', as: 'destroy_book' 
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
  
end
