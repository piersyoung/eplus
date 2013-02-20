class Student < ActiveRecord::Base
  attr_accessible :form_id, :name, :schoolreference
  
  belongs_to :form
  has_many :submissions
  has_many :schools, :through => :submissions
  has_many :nfers
  
  
  
  def applying?
  	if self.submissions.nil? || self.submissions.empty?
  		return false
  	else
  		return true
  	end
  end
  
  def has_offer?
  	subs = self.submissions
  	result = false
  	subs.each do |s|
  		if s.status.id == 3 || s.status.id == 4
  			result = true
  		end
  	end
  	return result
  end
  
  def wait_int?
  	subs = self.submissions
  	result = false
  	subs.each do |s|
  		if s.status.id == 2 || s.status.id == 7
  			result = true
  		end
  	end
  	return result
  end
  
  def rejected?
  	subs = self.submissions
  	result = false
  	subs.each do |s|
  		if s.status.id == 5
  			result = true
  		end
  	end
  	return result
  end
  
  def nfers?
  	if self.nfers.nil? || self.nfers.empty?
  		return false
  	else
  		return true
  	end
  end
  
  def nfer_latest_ss(subject)
  	e = Nfer.find(:all, :conditions=> {:student_id => self.id, :subject => subject}, :order=> "date_taken DESC")
  	#e = Nfer.find(:last, :conditions => ["student_id = ? and subject = ?", self.id, subject]).order_by("date_taken DESC")
  	if !e.nil? && !e.empty?
  		return e[0].ss
  	else
  		return 0.0
  	end
  end
  
  def nfer_latest_ss_average
  	count=2
  	e = self.nfer_latest_ss("English")
  	m = self.nfer_latest_ss("Maths")
  	
  	#if no result for a test average on the one, bootsy style
  	if (e == 0.0 || m = 0.0)
  		count = 1
  	end
  	return (e+m)/count
  end
  
end
