class AddYeargroupIdToForms < ActiveRecord::Migration
  def change
	  add_column :forms, :yeargroup_id, :integer
  end
end
