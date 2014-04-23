CodeKindaSmart::Application.routes.draw do

  resources :users, only: [:new, :create, :destroy, :index, :show] do
    resources :documents, only: [:new, :create]
  end
  

  resources :documents, only: [:index, :show, :destroy, :edit] do
    resources :annotations, only: [:index, :edit, :new, :create]
  end
  resources :annotations, only: [:show, :destroy]


  resource :session, only: [:new, :create, :destroy]

  root to: "documents#index"
end
