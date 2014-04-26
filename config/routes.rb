CodeKindaSmart::Application.routes.draw do

  resources :users, only: [:new, :create, :destroy, :index, :show, :update] do
    member do
      get "settings"
    end
    resources :documents, only: [:create]
  end

  resources :authors, only: [:new, :create, :destroy, :index, :show, :update]
  
  resources :documents, only: [:new, :index, :show, :destroy, :edit, :update] do
    resources :annotations, only: [:index, :edit, :new, :create]
  end
  resources :annotations, only: [:show, :destroy, :update]

  resource :session, only: [:new, :create, :destroy]

  root to: "documents#index"
end