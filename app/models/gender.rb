class Gender < ActiveRecord::Base
  attr_accessible :name
  has_many :schools
  has_and_belongs_to_many :schools

  def gender
  	if self.gender_id == 1
  		"male"
  	else
  		"female"
  	end
  end

end
