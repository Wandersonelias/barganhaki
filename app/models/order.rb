class Order < ApplicationRecord
  has_many   :order_items

  def calcula_validade
  end
end
