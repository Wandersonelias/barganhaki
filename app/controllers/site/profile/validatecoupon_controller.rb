class Site::Profile::ValidatecouponController < ApplicationController
  layout "profile"  
  before_action :set_orderitem, only: [:edit, :update]

  def verifyvalidity
     @orders = OrderItem.validar(params[:q]).verificar
     
  end

  def edit

  end

  def update
    if @orderitem.update(params_orderItem)  
        render :confirmeduse, notice: "Voucher validado com sucesso" 
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
