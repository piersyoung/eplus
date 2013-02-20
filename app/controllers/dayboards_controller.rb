class DayboardsController < ApplicationController
  # GET /dayboards
  # GET /dayboards.json
  def index
    @dayboards = Dayboard.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dayboards }
    end
  end

  # GET /dayboards/1
  # GET /dayboards/1.json
  def show
    @dayboard = Dayboard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dayboard }
    end
  end

  # GET /dayboards/new
  # GET /dayboards/new.json
  def new
    @dayboard = Dayboard.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dayboard }
    end
  end

  # GET /dayboards/1/edit
  def edit
    @dayboard = Dayboard.find(params[:id])
  end

  # POST /dayboards
  # POST /dayboards.json
  def create
    @dayboard = Dayboard.new(params[:dayboard])

    respond_to do |format|
      if @dayboard.save
        format.html { redirect_to @dayboard, notice: 'Dayboard was successfully created.' }
        format.json { render json: @dayboard, status: :created, location: @dayboard }
      else
        format.html { render action: "new" }
        format.json { render json: @dayboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dayboards/1
  # PUT /dayboards/1.json
  def update
    @dayboard = Dayboard.find(params[:id])

    respond_to do |format|
      if @dayboard.update_attributes(params[:dayboard])
        format.html { redirect_to @dayboard, notice: 'Dayboard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dayboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dayboards/1
  # DELETE /dayboards/1.json
  def destroy
    @dayboard = Dayboard.find(params[:id])
    @dayboard.destroy

    respond_to do |format|
      format.html { redirect_to dayboards_url }
      format.json { head :no_content }
    end
  end
end
