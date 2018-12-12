class Site::HomeController < ApplicationController
  layout "site"
  
  def index
    @categories = Category.all
    @companies = Company.all
    @products = Product.list_products_type.paginate(:page => params[:page], :per_page => 15)
    if @carrinho = cookies[:carrinho].present?
      @carrinho = JSON.parse(cookies[:carrinho])
    else
      @carrinho = []
    end
  end
  def aguardem
      render :aguardem
  end

  def remove_car
    if cookies[:carrinho].present?
      carrinho_padrao = JSON.parse(cookies[:carrinho])
      carrinho = []
      carrinho_padrao.each do |item|
          carrinho << item if item["id"] != params[:product_id]
      end

      cookies[:carrinho] = { value: carrinho.to_json, expires: 1.days.from_now, httponly: true }
    end
  
    redirect_to "/"
  end
end
