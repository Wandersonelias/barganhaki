class RemoveRefProductToCompany < ActiveRecord::Migration[5.2]
  def change
    remove_reference :companies, :product, foreign_key: true
  end
end
