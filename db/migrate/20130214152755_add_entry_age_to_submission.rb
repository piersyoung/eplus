class AddEntryAgeToSubmission < ActiveRecord::Migration
  def change
   	add_column :submissions, :entry_age, :integer
  end
end
