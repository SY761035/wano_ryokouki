class AddCategoryToPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :category, :string
  end
end
