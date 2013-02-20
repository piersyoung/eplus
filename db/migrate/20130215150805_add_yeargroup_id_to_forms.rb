class AddYeargroupIdToForms < ActiveRecord::Migration
  def change
	  add_column :Forms, :yeargroup_id, :integer
  end
end
