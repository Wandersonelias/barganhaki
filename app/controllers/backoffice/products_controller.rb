class Backoffice::ProductsController < ApplicationController
  layout "backoffice"
  before_action :set_product , only: [:edit, :update]

  def index
    @products = Product.all
  end
  def new
    @product = Product.new
  end
  
  def create
    
    @product = Product.create(params_product)
    if @product.save
      redirect_to backoffice_products_path, notice: "A categoria #{@product.title}, cadastrada com sucesso!"
    else
      render :new
    end


  end
  def edit
    
  end

  def update
      if @product.update(params_product)
        redirect_to backoffice_products_path, notice: "A categoria #{@product.title}, cadastrada com sucesso!"
      else
        render :edit
      end
  end
  
  def destroy
    @product = Product.find(params[:id])
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def params_product
    params.require(:product).permit(:id, :title, :description, :priceof, :pricefor, :user_id, :category_id, :image)

  end
end