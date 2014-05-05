CodeKindaSmart::Application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :documents do
      resources :annotations, only: [:index]
    end
    resources :annotations, except: [:index]
    get "/documents/:id/segments", to: "documents#segments", as: "segments"
  end

  resources :users, only: [:new, :create, :destroy, :index, :show, :update] do
    member do
      get "settings", as: "settings"
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

  get "/annotations/:id/upvote", to: "annotations#upvote", as: "upvote"
  get "/annotations/:id/downvote", to: "annotations#downvote", as: "downvote"

  get "/homepage", to: 'pages#homepage'
  get "/search", to: "pages#search"

  root to: "pages#homepage"
end