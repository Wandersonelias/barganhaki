class AddPriceOfToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :priceof, :decimal
  end
end
