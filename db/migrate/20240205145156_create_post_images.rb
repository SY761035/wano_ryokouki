class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.string :event_name
      t.text :caption
      t.integer :user_id
      t.integer :genre_id
      t.date :travel_date
      
      t.timestamps
    end
  end
end
