class Site::HomeController < ApplicationController
  layout "site"
  
  def index
    @categories = Category.all
    @companies = Company.all
    @products = Product.paginate(:page => params[:page], :per_page => 15)
    if @carrinho = cookies[:carrinho].present?
      @carrinho = JSON.parse(cookies[:carrinho])
    else
      @carrinho = []
    end
  end

  def remove_car
    if cookies[:carrinho].present?
      carrinho = JSON.parse(cookies[:carrinho])
      carrinho.delete(params[:product_id])
      cookies[:carrinho] = { value: carrinho.to_json, expires: 1.days.from_now, httponly: true } 
    end
  
    redirect_to "/"
  end
end
