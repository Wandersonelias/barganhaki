class Site::Profile::ValidatecouponController < ApplicationController
  layout "profile"  
  before_action :set_orderitem, only: [:edit, :update]

  def verifyvalidity
    @orders = OrderItem.validar(params[:q])
    if @orders.present?  
      @orders = OrderItem.where(:status => 0)
    else
        render :invalidvoucher
    end

  end
  def edit

  end

  def update
    if @orderitem.update(params_orderItem)  
        render :confirmeduse, notice: "Vouccher validado com sucesso" 
    else
        puts "Não deu"
    end
  end


  private
  def set_orderitem
    @orderitem = OrderItem.find(params[:id])
  end
  
  def params_orderItem
    params.require(:order_item).permit(:id, :status, :cupom)
  end




end
