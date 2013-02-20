class School < ActiveRecord::Base
  attr_accessible :address, :agefrom, :ageto, :county_id, :dayboard_id, :fax, :gender_id, :is_private, :name, :notes, :phone, :postcode, :religion_id, :size, :town, :web
  
    belongs_to :county
	belongs_to :dayboard
	belongs_to :gender
	belongs_to :religion
	belongs_to :curriculum
	
    has_many :submissions
    has_many :students, :through => :submissions
	
	#helper for private/state
	def status
		if self.is_private
			"private"
		else
			"state"
		end	
	end
	
	
	def subs_total
	#returns number of submissions made
		return self.submissions.length
	end
	
	def subs_count(s)
	#returns number of applications that get status "s"
	  	subs = Submission.find(:all, :conditions=> {:school_id => self.id, :status_id => s})
	  	return subs.length

	end
	
	def success_rate
	#returns array of the number of children we manage to get in as a percentage, offer and accept
		total = self.subs_total
		offer = subs_count(3)
		success = subs_count(3)+subs_count(4)
		#yes, no, total, percent
		return [success, total-success, total, 100*(subs_count(3).to_f/total.to_f), 100*(subs_count(4).to_f/total.to_f)]
		
	
	end
	
	def get_pass_reqs_by_year
	#returns array in form [year, average_pass_nfer, average fail_nfer] BIT USELESS??
		subs = Submission.find(:all, :order=>"updated_at", :conditions=> {:school_id => self.id, :status_id => [3,4,5]})
		
		
		return subs
	end
	
	def average_nfer
		#returns the average nfer score of all children with offers, taken or not.
		subs = self.submissions
		if subs.nil?
			return 0.0
		else
			#get array of all students offers/places
			success_list = []
			subs.each do |s|
				if s.status_id == 3 || s.status_id == 4
					success_list << s.student
				end
			end
			
			#for each offer/place get average nfer
			averages_added = 0.0
			averages_count = 0
			success_list.each do |s|
					a = s.nfer_latest_ss_average
				#if a dud result/0.0 returned so check sensible before putting in
				if a > 50.0
					averages_added = averages_added + a
					averages_count = averages_count + 1
				end
			end 
			#average the averages
			return averages_added/averages_count
		
		end
	end	
	
end
