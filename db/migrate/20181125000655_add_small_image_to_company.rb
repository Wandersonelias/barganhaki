class AddSmallImageToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies , :small_image, :string
  end
end
