class Site::CompaniesController < ApplicationController
  layout "site"
  def index
    if @carrinho = cookies[:carrinho].present?
      @carrinho = JSON.parse(cookies[:carrinho])
    else
    @carrinho = []
    end
    @categories = Category.all
    @companies = Company.all
  end
  def show
    if @carrinho = cookies[:carrinho].present?
        @carrinho = JSON.parse(cookies[:carrinho])
    else
      @carrinho = []
    end
    @categories = Category.all
    #--------------------------------------------------
    @company = Company.find(params[:id])
    @products = Product.where(:company_id => @company.id)
    
       
    
  end
end
=begin
@categoria = Category.find(params[:id])
    @products = Product.where(:category_id => @categoria.id)   
    if @products.empty?
      render :errorcat
    else
        render :show
    end
=end