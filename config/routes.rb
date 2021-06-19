Rails.application.routes.draw do
  devise_for :users
  root to: "cards#index"
  resources :cards do
    resources :records, only: [:index, :create, :destroy]
    resource :favorites, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only:[:show]
end
