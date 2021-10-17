Rails.application.routes.draw do
  devise_for :users
  post '/users/test_sign_in', to: 'users#test_sign_in'
  root to: "cards#index"
  resources :cards do
    collection do
      get 'search'
    end
    resources :records, only: [:index, :create, :destroy] do
      collection { post :import}
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
