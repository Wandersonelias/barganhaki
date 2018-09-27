class Backoffice::AdminsController < ApplicationController
  before_action :set_admin, only: [:edit, :update, :destroy]
  layout "backoffice"


  def index
  # @admins = Admin.all
    @admins = Admin.com_acesso_total # com uso de lambda arrow
    @admins = Admin.com_acesso_restrito # com uso de lambda arrow
  end
  #metodo para criar novo admin
  def new
    @admin = Admin.new 
  end
  #continuação do metod
  def create
    @admin = Admin.new(params_admins)
    if @admin.save
        redirect_to backoffice_admins_path, notice: "Mensagem"
    else
      render :new , notice: "A campo descrição não pode ficar em branco!"
    end
  end
  def edit
  
  end
  def update

      passwd = params[:admin][:password]
      passwd_confirm = params[:admin][:password_confirmation]
      #faz a verificação se o password esta em branco
      # e ativa o metodo delete para contornar o 
      if passwd.blank? && passwd_confirm.blank?
        params[:admin].delete(:password)
        params[:admin].delete(:password_confirmation)
      
      end
    if @admin = Admin.update(params_admins)
      redirect_to backoffice_admins_path , notice: "Mensagem"
    else
      render :edit   , notice: "Mensagem"
    end
  end


  def destroy
    #@admin = Admin.find(params[:id])
      admin_email = @admin.email
    
    if @admin.destroy
      redirect_to backoffice_admins_path, notice: "Mensagem"
    else
      render :index
    end
  end

  def set_admin
    @admin = Admin.find(params[:id]) 
  end
  private
    def params_admins
      params.require(:admin).permit(:email, :name, :password, :password_confirmation)
    end



end
