class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product





#Metodo gerar numeração para cupom desconto
  def gera_cupom
    cupom = rand(36**8).to_s(36)
    return cupom.upcase
  end

end
