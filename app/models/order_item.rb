class OrderItem < ApplicationRecord


  belongs_to :order
  belongs_to :product


  #scope :validar, ->(q) {where("cupom LIKE ?","%#{q}%")}
  scope :validar, ->(q) {where("cupom LIKE ?","#{q}")}
  scope :verificar, -> {where(:status => 0)}
  


#Metodo gerar numeração para cupom desconto
  def gera_cupom
    cupom = rand(36**8).to_s(36)
    return cupom.upcase
  end

end
