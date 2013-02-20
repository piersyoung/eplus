class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :schoolreference
      t.integer :form_id

      t.timestamps
    end
  end
end
