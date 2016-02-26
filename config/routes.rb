Rails.application.routes.draw do

  resources :orders, only: [:index, :create] do
    collection do
      get :listing
    end
  end
  root 'orders#index'

end
