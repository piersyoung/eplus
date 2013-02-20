class NfersController < ApplicationController
  # GET /nfers
  # GET /nfers.json
  def index
    @nfers = Nfer.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nfers }
    end
  end

  # GET /nfers/1
  # GET /nfers/1.json
  def show
    @nfer = Nfer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nfer }
    end
  end

  # GET /nfers/new
  # GET /nfers/new.json
  def new
    @nfer = Nfer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nfer }
    end
    #for bulk imports
    #http://www.funonrails.com/2012/01/csv-file-importexport-in-rails-3.html
  end    
    
  def import
     require 'csv'
        if request.post? && params[:file].present?
            infile = params[:file].read
            n, errs = 0, []
            CSV.parse(infile) do |row| n += 1
                # SKIP: header i.e. first row OR blank row
                #                next if n == 1 or row.join.blank?
                # build_from_csv method will map customer attributes &
                # build new customer record
                nfer = Nfer.build_from_csv(row)
                # Save upon valid
                # otherwise collect error records to export
                if nfer.valid?
                    nfer.save
                    else
                    errs << row
                end
            end
            
            # Export Error file for later upload upon correction
            if errs.any?
                errFile ="errors_#{Date.today.strftime('%d%b%y')}.csv"
                errs.insert(0, Student.csv_header)
                errCSV = CSV.generate do |csv|
                    errs.each {|row| csv << row}
                end
                send_data errCSV,
                :type => 'text/csv; charset=iso-8859-1; header=present',
                :disposition => "attachment; filename=#{errFile}.csv"
                else
                flash[:notice] = I18n.t('Student import success')
                redirect_to :action => "index"
            end
        end
    end
 

  # GET /nfers/1/edit
  def edit
    @nfer = Nfer.find(params[:id])
  end

  # POST /nfers
  # POST /nfers.json
  def create
    @nfer = Nfer.new(params[:nfer])

    respond_to do |format|
      if @nfer.save
        format.html { redirect_to @nfer, notice: 'Nfer was successfully created.' }
        format.json { render json: @nfer, status: :created, location: @nfer }
      else
        format.html { render action: "new" }
        format.json { render json: @nfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nfers/1
  # PUT /nfers/1.json
  def update
    @nfer = Nfer.find(params[:id])

    respond_to do |format|
      if @nfer.update_attributes(params[:nfer])
        format.html { redirect_to @nfer, notice: 'Nfer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nfers/1
  # DELETE /nfers/1.json
  def destroy
    @nfer = Nfer.find(params[:id])
    @nfer.destroy

    respond_to do |format|
      format.html { redirect_to nfers_url }
      format.json { head :no_content }
    end
  end
  
  def clean_up
  	@nfers = Nfer.all
  	
  	#strip empty
  	@nfers.each do |n|
  		if n.raw.nil?
  			n.destroy
  		end
  	end
  	#link ids
  	@nfers.each do |n|
  		if n.student_id.nil?
	  		@s = Student.find(:first, :conditions => {:schoolreference => n.schoolreference})
  			n.update_attribute(:student_id, @s.id)
  		end
  	end
  	
  	
  
  end
end
