class CreateDayboards < ActiveRecord::Migration
  def change
    create_table :dayboards do |t|
      t.string :name

      t.timestamps
    end
  end
end
