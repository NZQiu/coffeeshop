Rails.application.routes.draw do

  resources :orders, only: [:index, :create] do
    collection do
      get :listing
    end
  end
  root 'orders#index'

  namespace :api, defaults: {format: :json} do
    resources :orders, only: [:index, :create]
    resources :items, only: [:index]
  end

end
