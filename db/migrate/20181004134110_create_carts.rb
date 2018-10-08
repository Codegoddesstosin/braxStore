class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :status

      t.timestamps null: false
    end
  end
end
