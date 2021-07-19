Rails.application.routes.draw do
  devise_for :users
  root to: "cards#index"
  resources :cards do
    collection do
      get 'search'
    end
    resources :records, only: [:index, :create, :destroy] do
      collection { post :import}
    end
    resources :comments, only: [:create]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only:[:show] do
    resources :notices, only: [:index, :create, :destroy]
  end
end
