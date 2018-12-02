Rails.application.routes.draw do
  
  
  namespace :backoffice do
    get 'users/index'
  end
  namespace :site do
    resources :companies, only: [:index, :show]
  end
  namespace :backoffice do
    get 'companies/index'
  end
  get 'finalizar/compra' , to: "checkout/payments#formapagamento"
  post 'finalizar/compra' , to: "checkout/payments#create"


  namespace :backoffice do
    resources :products
  end
  resources :compras, only: [:create , :show, :index]
  resources :items
  
  namespace :checkout do
    resources :payments, only: [:create, :index]
  end

  namespace :site do
    namespace :profile do
      get 'products/index'
    end
  end
  #rotas para pagina inicial do sistema
  namespace :site do
    namespace :profile do
      get 'dashboard/index'
    end
  end
  
  get 'remover_carrinho', to: 'site/home#remove_car'
  get 'remover', to: 'compras#remove_item'

  #route direction for dashboard
  get 'backoffice', to: 'backoffice/dashboard#index'

  namespace :backoffice do
    resources :categories, except: [:show, :destroy]
    resources :admins, except: [:show]
    resources :users
    resources :companies
    #get 'categories/index'
    get 'backoffice', to: 'dashboard#index'
    #rotas para administradores do sistema
    
  end
  #resources :categories, except: [:show]
    
  #routes do pagina inicial
  namespace :site do
    get 'home', to: 'home#index'
    get 'search', to: 'search#products' #rotas de pesquisa
    #rotas para o dashboard perfil
    namespace :profile do
      resources :dashboard, only: [:index]
      resources :products
     
    end
    resources :items#simulação de rotas de itens
    resources :product_detail, only: [:show]
    resources :categories, only: [:show]
  end
  #routes da pagina de administração 
  
  devise_for :admins, :skip => [:registrations]
  devise_for :users 
  
  #rota default - para entrada no sistema
  root 'site/home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
