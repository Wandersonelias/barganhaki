class Site::SearchController < ApplicationController
   layout "site"
    def products
        @products = Product.buscar(params[:q])
        @categories = Category.all
        if cookies[:carrinho].present?
            @carrinho = JSON.parse(cookies[:carrinho]) 
        else
            @carrinho = []
        end

    end
end
