class Form < ActiveRecord::Base
  attr_accessible :name, :user_id, :yeargroup_id
  
   belongs_to :user
   has_many :students

end
