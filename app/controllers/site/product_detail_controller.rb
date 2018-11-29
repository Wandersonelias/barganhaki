class Site::ProductDetailController < ApplicationController
    layout "site"


    def show
        @product = Product.find(params[:id])
        @company = Company.where(:product_id => @product.id)
        @categories = Category.all
        if @carrinho = cookies[:carrinho].present?
            @carrinho = JSON.parse(cookies[:carrinho])
          else
            @carrinho = []
          end
    end






end
