class Nfer < ActiveRecord::Base
  attr_accessible :raw, :schoolreference, :ss, :student_id, :subject, :date_taken
  
  belongs_to :student
  
private
  #FOR BULK UPLOAD 

    #for bulk upload
    def self.csv_header
        "Name,email".split(',')
    end

    def self.build_from_csv(row)
        # find existing user from email or create new
        n   = Nfer.new
        n.attributes = {
            :subject => row[0],
            :raw => row[1],
            :ss => row[2],
            :schoolreference =>row[3],
            :date_taken => row[4]
        }
    return n 
    end


end
