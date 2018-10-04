class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.float :price
      t.string :image

      t.timestamps null: false
    end
  end
end
