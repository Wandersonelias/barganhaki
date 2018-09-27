class AddPriceForToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :pricefor, :decimal
  end
end
