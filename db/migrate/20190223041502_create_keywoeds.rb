class CreateKeywoeds < ActiveRecord::Migration[5.2]
  def change
    create_table :keywoeds do |t|
      t.integer :shop_id
      t.string :word
      t.string :url

      t.timestamps
    end
  end
end
