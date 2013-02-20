class HomeController < ApplicationController

  layout 'home'
  def index
    @subs= Submission.order("updated_at DESC").limit(10)
	
	@forms = Form.where("yeargroup_id = ?", 6)
	@year6 = []
	@forms.each do |f|
		f.students.each do |s|
		@year6 << s
		end
	end
	
	@num_year6 = @year6.size
	@applying = subs_by_year(6)
	@details = sub_details_by_year(6)
	
  end
  
  
  def data
  end
  
  def about
  end
end
