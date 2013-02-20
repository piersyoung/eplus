class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :pupil_id
      t.integer :school_id
      t.integer :status_id
      t.text :notes

      t.timestamps
    end
  end
end
