class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def subs_by_year(y)
  #returns number of children with open application
	num_subs = 0
	forms = Form.where("yeargroup_id = ?", y)
	forms.each do |f|
		f.students.each do |s|
			if s.applying?
				num_subs = num_subs + 1
			end
		end
	end
	return num_subs
  end
  
  def sub_details_by_year(y)
  #returns array of [applying, waitlist, places, no_place]
	details =[0,0,0,0]
	forms = Form.where("yeargroup_id = ?", y)
	forms.each do |f|
		f.students.each do |s|
			if s.has_offer?
				details[2] = details[2] + 1			
			elsif s.wait_int?
				details[1] = details[1] + 1					
			elsif s.applying?
				details[0] = details[0] + 1
			elsif s.rejected?
				details[3] = details[3] + 1	end
		end
	end
	return details
  en
  end
  
  def offers_by_year(y)
  end
  
  def waitlist_interview_by_year(y)
  end
  
  def rejections_by_year(y)
  end
  
end
