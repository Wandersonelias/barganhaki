class Order < ApplicationRecord
  require 'rqrcode_png'
  has_many   :order_items


  scope :validar, ->(q) {where("cupom LIKE ?","%#{q}%")}
  
  def calcula_validade
  end
end
