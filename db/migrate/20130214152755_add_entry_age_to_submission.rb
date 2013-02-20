class AddEntryAgeToSubmission < ActiveRecord::Migration
  def change
   	add_column :Submissions, :entry_age, :integer
  end
end
