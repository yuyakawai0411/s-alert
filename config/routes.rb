Rails.application.routes.draw do
  devise_for :users
  root to: "cards#index"
  resources :cards do
    resources :records, only: [:index, :create, :edit, :update]
  end
end
