class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.integer :user_id
      t.string :shopname
      t.string :location

      t.timestamps
    end
  end
end
