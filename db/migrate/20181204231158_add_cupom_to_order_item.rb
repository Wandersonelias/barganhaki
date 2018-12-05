class AddCupomToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :cupom, :string
  end
end
