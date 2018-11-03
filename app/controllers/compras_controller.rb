class ComprasController < ApplicationController
    
    layout "site"    
    def index
        @categories = Category.all
        @products = Product.all
        if @carrinho = cookies[:carrinho].present?
            @carrinho = JSON.parse(cookies[:carrinho])
          else
            @carrinho = []
        end
    end
    
    def create
        #debugger
        carrinho  = [] #array onde serão armazenados os produtos
        carrinho = JSON.parse(cookies[:carrinho]) if cookies[:carrinho].present? #verifica se a algun produtos
        
        unless carrinho.include?(params[:product_id])
            carrinho << params[:product_id] #array de produtos
        end

        cookies[:carrinho] = { value: carrinho.to_json, expires: 1.days.from_now, httponly: true }

        redirect_to "/"
        
        
        
    end
    
    def remove_item
        if cookies[:carrinho].present?
        carrinho = JSON.parse(cookies[:carrinho])
        carrinho.delete(params[:product_id])
        cookies[:carrinho] = { value: carrinho.to_json, expires: 1.days.from_now, httponly: true }
        end
        redirect_to "/compras"
    end




end
