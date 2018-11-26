class AddRefProductToCompany < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :product, foreign_key: true
  end
end
