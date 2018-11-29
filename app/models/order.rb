class Order < ApplicationRecord
  require 'rqrcode_png'
  has_many   :order_items

  def calcula_validade
  end
end
