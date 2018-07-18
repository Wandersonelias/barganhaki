Rails.application.routes.draw do
  namespace :backoffice do
    get 'dashboard/index'
  end
  root to: "home#index"
  devise_for :admins
  devise_for :users
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
