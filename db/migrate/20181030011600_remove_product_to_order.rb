class RemoveProductToOrder < ActiveRecord::Migration[5.2]
  def change
    remove_reference :orders , :product 
  end
end
