class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :eamil
      t.string :password

      t.timestamps
    end
  end
end
