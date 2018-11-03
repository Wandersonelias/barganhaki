=begin
module CurrentCompra
    
    extend ActiveSupport::Concern
    
    #metodo que chama uma intancia de carrinho de compras
    private 
    def set_compra
        Compra.find(session[:compra_id])
    rescue ActiveRecord::RecordNotFound
        compra = Compra.create
        session[:compra_id] = compra.id
        compra
    end
end
=end
