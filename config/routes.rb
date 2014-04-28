CodeKindaSmart::Application.routes.draw do

  resources :users, only: [:new, :create, :destroy, :index, :show, :update] do
    member do
      get "settings"
    end
    resources :documents, only: [:create]
  end

  resources :notifications, only: [:index, :show]

  resources :authors, only: [:new, :create, :destroy, :index, :show, :update]
  
  resources :documents, only: [:new, :index, :show, :destroy, :edit, :update] do
    resources :annotations, only: [:index, :new, :create]
  end
  resources :annotations, only: [:show, :destroy, :update, :edit]

  resource :session, only: [:new, :create, :destroy]

  get "/homepage", to: 'pages#homepage'
  get "/search", to: "pages#search"

  root to: "documents#index"
end