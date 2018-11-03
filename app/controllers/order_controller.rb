class OrderController < ApplicationController
    def create
        #debugger
        carrinho  = [] #array onde serão armazenados os produtos
        if cookies[:carrinho].present? #verifica se a algun produtos
            cookies[:carrinho] = JSON.parse(cookies[:carrinho])
        end
        carrinho << params[:product_id] #array de produtos
        
        cookies[:carrinho] = { value: carrinho.to_json, expires: 1.days.from_now, httponly: true } #prazo de vallidade dos cookies
       # @compra = Compra.new(params[:product_id])
        #@compra.save
            respond_to do |format|
                format.html { redirect_to compras_path, notice: 'Item was successfully created.' }
             end
        puts ">>>>>>>>>>>>>> #{carrinho} "
    end


    #private 
    
    def parmas_post
        params.require(:order).permit(:product)
    end

end
