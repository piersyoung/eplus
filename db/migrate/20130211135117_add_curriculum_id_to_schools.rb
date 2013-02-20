class AddCurriculumIdToSchools < ActiveRecord::Migration
  def change
  	add_column :schools, :curriculum_id, :integer
  end
end
