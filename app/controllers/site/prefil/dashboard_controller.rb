class Site::Prefil::DashboardController < ApplicationController
  layout "perfil"
  def index
    @categories = Category.all
    @produtos = Product.all
  end
  

  def new 
    @produto = Product.new
  end

  def create 
    @produto = Product.new(produtos_params)
    if @produto.save
      #redirect_to "caminho para redirecionamento"
    else
      render :new
    end
  end




  private 
  def produtos_params
    params.require(:products).permit(:title, :description )
  end

end
