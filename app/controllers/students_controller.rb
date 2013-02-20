class StudentsController < ApplicationController
  # GET /students
  # GET /students.json
  
  layout 'students'
  
  def index
    @students = Student.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.find(params[:id])

    @maths = ""
    @english = ""
    @results = @student.nfers.order("date_taken ASC")
    @maths_results = []
    @english_results = []

    
    if @student.nfers?
    	@results.each do |r|
    		if r.subject == "Maths"
    			@maths_results << r
    			@maths << "["
    			date_string = r.date_taken.strftime("%Y-%m-%d")
				@maths << (Time.parse(date_string.to_s).utc.to_i*1000).to_s
				@maths << ","
				@maths << r.ss.to_s
				@maths << "], "
    		end
    		if r.subject == "English"
    			@english_results << r
      			@english << "["
    			date_string = r.date_taken.strftime("%Y-%m-%d")
				@english << (Time.parse(date_string.to_s).utc.to_i*1000).to_s
				@english << ","
				@english << r.ss.to_s
				@english << "], "
    		end    	
    	end	
    end

    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render json: @student, status: :created, location: @student }
      else
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end
end
