class SmallImageToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products , :small_image, :string
  end
end
