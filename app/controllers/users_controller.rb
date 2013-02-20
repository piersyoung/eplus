class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
  
  def do_reset_password
        id = params[:user_id]
        @user = User.find(params[:user_id].to_i)

        # there may be a better way of doing this, devise should be able to give us these messages
        if params[:user][:password] != params[:user][:password_confirmation]
            flash[:alert] = "Passwords must match." 
              redirect_to :back
              return
        end
       
        if @user.reset_password!(params[:user][:password],params[:user][:password_confirmation])
            @user.save
            respond_to do |format|
                format.html { redirect_to '/', notice: 'Your password has been changed.' }
            end
        else
            flash[:alert] = "Invalid password, must be at least 6 charactors." 
              redirect_to :back 
        end
    end
  
   #for bulk imports
    #http://www.funonrails.com/2012/01/csv-file-importexport-in-rails-3.html
    
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
                user = User.build_from_csv(row)
                # Save upon valid
                # otherwise collect error records to export
                if user.valid?
                    user.save
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
end