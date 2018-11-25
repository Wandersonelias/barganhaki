class Backoffice::CompaniesController < ApplicationController
  layout "backoffice"
  before_action :set_company , only: [:edit, :update]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new #Ele cria uma no instancia da variavel 
  end

  def create
    @company = Company.create(params_company)
    
    if @company.save
      redirect_to backoffice_companies_index_path , notice: "A categoria #{@company.name}, cadastrada com sucesso!" 
    else
      render :new
    end
  end
  def edit 
  
  end
  
  def update
    if @company.update(params_company)
      redirect_to backoffice_companies_index_path, notice: "A Empresa #{@company.name}, alterada com sucesso!"
    else
      render :edit 
    end
  end

private
  def set_company
    @company = Company.find(params[:id])
  end

  def params_company
    params.require(:company).permit(:name, :cnpj, :address, :neighborhood, :zipcode, :country, :longitude, :latidude, :category_id, :user_id, :image)
  end

end
