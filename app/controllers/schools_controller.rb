class SchoolsController < ApplicationController
  # GET /schools
  # GET /schools.json
  
  layout 'schools', :only => [:show]
  
  def index
    @schools = School.order("name")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    @school = School.find(params[:id])
	@subs = @school.submissions
	#Gmap hack for static map
	#html_safe to render string as html
	#TO COME BACK TO:
	#need to try to embed google map rather than static and link?

	#a = "<iframe width=\"425\" height=\"350\" frameborder=\"0\" scrolling=\"no\" marginheight=\"0\" marginwidth=\"0\" src=\"http://maps.google.co.uk/maps?f=q&amp;source=s_q&amp;hl=en&amp;q=" 
	#b = "&amp;aq=&amp;vpsrc=0&amp;ie=UTF8&amp;hq=&amp;hnear="
	#c = ",+United+Kingdom&amp;t=m&amp;z=13&amp;output=embed\"></iframe><br /><small><a href=\"http://maps.google.co.uk/maps?f=q&amp;source=embed&amp;hl=en&amp;q="
	#d = "w6+0yd&amp;aq=&amp;vpsrc=0&amp;ie=UTF8&amp;hq=&amp;hnear="
	#e = ",+United+Kingdom&amp;t=m&amp;z=14\" style=\"color:#0000FF;text-align:left\">View Larger Map</a></small>"
	
	#@mapembed = a + @school.postcode + b + @school.postcode + c + @school.postcode + d + @school.postcode + e
	#@mapembed.html_safe
	
	@mapurl = "http://maps.googleapis.com/maps/api/staticmap?center=" + @school.postcode + "&zoom=12&size=300x300&maptype=roadmap
&markers=color:blue%7C"+ @school.postcode + "&sensor=false"
    @maplink = "http://maps.google.co.uk/maps?q=" + @school.postcode + "&hl=en&vpsrc=0&hnear=" + @school.postcode + ",+United+Kingdom&t=m&z=13"


	@offers = ""
    @rejections = ""

    @offers_list = []
    @rejections_list = []
    
    #
    
    
    
    if @school.subs_total > 0
	
	    @subs = @school.submissions
	
	    #get list of years results
	    #get hit/miss arrays of [2013, 123.4] etc
    	years_list = []
	    @subs.each do |s|
  		  	years_list << s.updated_at.strftime("%Y")
  		  	if s.status_id == 3 || s.status_id == 4
  		  		@offers_list << [s.updated_at.strftime("%Y"), s.student.nfer_latest_ss_average]
  		  	end
  		  	if s.status_id == 5
  		  		@rejections_list << [s.updated_at.strftime("%Y"), s.student.nfer_latest_ss_average]
  		  	end
  	    end
   		
   		years_list.uniq!
    	
    	years_list.each do |y|
    		#set up date part of data
    		date_string = "#{y}-01-01"
    		@offers << "["
    		@offers << (Time.parse(date_string.to_s).utc.to_i*1000).to_s
    		@offers << ","
    		@rejections << "["
    		@rejections << (Time.parse(date_string.to_s).utc.to_i*1000).to_s
    		@rejections << ","    	
    		
    		#set up NFER part of data
    		hit = 0.0
    		miss= 0.0
    		hitcount = 0
    		misscount = 0
    		@offers_list.each do |o|
    			if o[0] == y
    				hitcount = hitcount + 1
    				hit = hit + o[1]
    			end
    		end
    		@rejections_list.each do |r|
    			if r[0] == y
    				misscount = misscount + 1
    				miss = miss + r[1]
    			end
    		end
    		
    		@offers << (hit/hitcount).to_s
    		@offers << "], "
    		@rejections << (miss/misscount).to_s
    		@rejections << "], "    		
    	end
    	
    
    	
    end


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @school }
    end
  end

  # GET /schools/new
  # GET /schools/new.json
  def new
    @school = School.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @school }
    end
  end

  # GET /schools/1/edit
  def edit
    @school = School.find(params[:id])
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(params[:school])

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render json: @school, status: :created, location: @school }
      else
        format.html { render action: "new" }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /schools/1
  # PUT /schools/1.json
  def update
    @school = School.find(params[:id])

    respond_to do |format|
      if @school.update_attributes(params[:school])
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school = School.find(params[:id])
    @school.destroy

    respond_to do |format|
      format.html { redirect_to schools_url }
      format.json { head :no_content }
    end
  end
end
