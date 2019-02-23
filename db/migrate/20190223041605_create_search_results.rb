class CreateSearchResults < ActiveRecord::Migration[5.2]
  def change
    create_table :search_results do |t|
      t.integer :keyword_id
      t.date :search_date
      t.string :rank

      t.timestamps
    end
  end
end
