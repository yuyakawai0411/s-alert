Rails.application.routes.draw do
  devise_for :users
  root to: "cards#index"
  resources :cards do
    collection do
      get 'search'
    end
    resources :records, only: [:index, :create, :destroy] do
      collection { post :import}
      collection { get :biorhythm}
    end
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only:[:show, :edit, :update, :destroy] do
    member { get :post_cards }
    member { get :favorite_cards }
    resources :notices, only: [:index, :create, :destroy]
  end
end
