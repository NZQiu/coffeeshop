Rails.application.routes.draw do

  resources :orders, only: [:index, :new, :create] do
    collection do
      get :listing
    end
  end
  root 'orders#index'

end
