class Backoffice::UsersController < ApplicationController
  layout "backoffice"
  
  before_action :set_users, only: [:edit, :update]

  def index
    @users = User.all
  end
  def edit

  end
  def update
    passwd = params[:user][:password]
    passwd_confirm = params[:user][:password_confirmation]
    #faz a verificação se o password esta em branco
    # e ativa o metodo delete para contornar o 
    if passwd.blank? && passwd_confirm.blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @admin = User.update(params_users)
      redirect_to backoffice_users_path , notice: "Mensagem"
    else
      render :edit   , notice: "Mensagem"
    end

  end

  private
  def set_users
    @user = User.find(params[:id])
  end

  def params_users
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :status, :company_id)
  end


end
