class Backoffice::CategoriesController < ApplicationController


  before_action :set_category, only: [:edit, :update]
  
  layout "backoffice"
  
  def index
    @categories = Category.all
  end


  def new
    @category = Category.new
  end

  #metodo que faz a edição das categoria
  def create
    @category = CategoryService.create(params_category)
    
    unless @category.errors.any?
      redirect_to backoffice_categories_path, notice: "A categoria #{@category.description}, cadastrada com sucesso!"
    else
      render :new , notice: "A campo descrição não pode ficar em branco!"
    end

  end

  def edit

    

  end

  def update
    debugger
    if @category.update(params_category)
      redirect_to backoffice_categories_path, notice: "A categoria #{@category.description}, Atualizada com sucesso!"
     else
      render :edit
     end
  end

  def set_category
    @category = Category.find(params[:id])
  end


private 
  def params_category 
     params.require(:category).permit(:description,:icon)
  end
end
