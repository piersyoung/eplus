class CreateNfers < ActiveRecord::Migration
  def change
    create_table :nfers do |t|
      t.string :subject
      t.float :raw
      t.float :ss
      t.string :student_id
      t.string :schoolreference
	  t.datetime :date_taken
	  
      t.timestamps
    end
  end
end
