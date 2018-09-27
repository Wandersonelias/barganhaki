Rails.application.routes.draw do
  namespace :site do
    namespace :prefil do
      get 'dashboard/index'
    end
  end
  namespace :backoffice do
    
  end
  #route direction for dashboard
  get 'backoffice', to: 'backoffice/dashboard#index'
  
  resources :categories, except: [:show]

  namespace :backoffice do
    resources :admins, except: [:show]
    #get 'categories/index'
    get 'backoffice', to: 'dashboard#index'
    #rotas para administradores do sistema
    
  end
  
  #namespace :usuario do
   # resources :users
    #verificação de rotas para o produtos
  #  resources :products
  #end

  
  
  #routes do pagina inicial
  namespace :site do
    get 'home', to: 'home#index'
    
    #rotas para o dashboard perfil
    namespace :prefil do
      resources :dashboard, only: [:index]
      resources :products
    end
  
  end
  #routes da pagina de administração
   
  
  
  devise_for :admins, :skip => [:registrations]
  devise_for :users 
  
  #rota default
  root 'site/home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
