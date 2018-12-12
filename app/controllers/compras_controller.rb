class ComprasController < ApplicationController
    
    layout "site"    
    def index
        @categories = Category.all
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
        
        unless carrinho.map{|c| c["id"]}.include?(params[:product_id])
            carrinho << {"id": params[:product_id], quantidade: 1 } #array de produtos
        end

        cookies[:carrinho] = { value: carrinho.to_json, expires: 1.days.from_now, httponly: true }

        redirect_to "/"
        
        
        
    end
    
    def remove_item
        if cookies[:carrinho].present?
            carrinho_padrao = JSON.parse(cookies[:carrinho])
            carrinho = []
            carrinho_padrao.each do |item|
                carrinho << item if item["id"] != params[:product_id]
            end

            cookies[:carrinho] = { value: carrinho.to_json, expires: 1.days.from_now, httponly: true }
        end
        redirect_to "/compras"
    end




end
