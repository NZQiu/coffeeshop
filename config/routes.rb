Rails.application.routes.draw do
  get 'new' => 'orders#new'
  resources :orders, only: [:new, :create, :index] do
    get :type, on: :collection
    get :size, on: :collection
  end

  root 'orders#index'

end
