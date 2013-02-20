class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.boolean :is_private
      t.integer :gender_id
      t.integer :dayboard_id
      t.integer :religion_id
      t.text :address
      t.string :town
      t.integer :county_id
      t.string :postcode
      t.string :phone
      t.string :fax
      t.string :web
      t.integer :size
      t.integer :agefrom
      t.integer :ageto
      t.text :notes

      t.timestamps
    end
  end
end
