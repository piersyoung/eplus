class CreatePostcodes < ActiveRecord::Migration
  def change
    create_table :postcodes do |t|
      t.string :code
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
