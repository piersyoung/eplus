module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  
  def sub_label(submission)
  	case submission.status.id # a_variable is the variable we want to compare
		when 1    #open
  			return "label" 
		when 2    #interviews
			return "label label-warning"
  		when 3    #offer
			return "label label-info"
  		when 4    #place
			return "label label-success"
  		when 5    #rejection
			return "label label-important"
  		when 6    #not interested
			return ""
  		when 7    #wait list
  			return "label label-inverse"
		else
			return ""

	end
  end

end
