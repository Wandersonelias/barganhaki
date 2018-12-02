class AddSituationAndQuantityToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :situation, :integer #vai verificar a situação dos produtos
  
  end
end
