Rails.application.routes.draw do
  root 'orders#index'
  get 'new' => 'orders#new'
  get 'orders/type'
  get 'orders/size'
end
