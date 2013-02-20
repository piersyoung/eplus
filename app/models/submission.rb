class Submission < ActiveRecord::Base
  attr_accessible :notes, :student_id, :school_id, :status_id
  
  belongs_to :student
  belongs_to :school
  belongs_to :status
  
  
  

  
end
