class Site::CategoriesController < ApplicationController
    layout "site"
    def show
        if @carrinho = cookies[:carrinho].present?
            @carrinho = JSON.parse(cookies[:carrinho])
          else
            @carrinho = []
        end
        @categories = Category.all
        @categoria = Category.find(params[:id])
        @products = Product.where(:category_id => @categoria.id)
        @companies = Company.where(:category_id => @categoria.id)


        if @products.empty?
            render :errorcat
        else
            render :show
        end
       
    end
end
