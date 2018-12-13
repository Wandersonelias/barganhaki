class Site::Profile::ProductsController < ApplicationController
  layout "profile"

    before_action :set_product , only: [:edit, :update]
    def index
        @products = Product.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 5)
        #@products = Product.user_product(current_user)
        #@products = Product.paginate(:page => params[:page], :per_page => 5)
        
    end
    
    def new
        @product = Product.new
    end

    def create
        @product = Product.create(params_products)
        @product.user = current_user
        @product.company_id = current_user.company_id 
        if @product.save
            redirect_to site_profile_products_path , notice: "A Produto #{@product.title}, Atualizada com sucesso!"
        else
            render :new
        end
    end


    def edit
        
    end


    def update
        if @product.update(params_products)
            redirect_to site_profile_products_path , notice: "A Produto #{@product.title}, Atualizada com sucesso!"
        else
            render :edit
        end

    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        redirect_to site_profile_products_path, notice: "O produto #{@product.title}, foi removido com sucesso!"
    end
    
    def set_product
        @product = Product.find(params[:id])
    end

private
    def params_products
        params.require(:product).permit(:id, :image, :title, :description, :category_id, :priceof, :pricefor, :user, :situation, :company_id)
    end
end

