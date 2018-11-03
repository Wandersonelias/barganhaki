class Site::CategoriesController < ApplicationController
    layout "site"
    def show
        @categories = Category.all
        @categoria = Category.find(params[:id])
        @products = Product.where(:category_id => @categoria.id)
        if @carrinho = cookies[:carrinho].present?
            @carrinho = JSON.parse(cookies[:carrinho])
          else
            @carrinho = []
        end
    end
end
