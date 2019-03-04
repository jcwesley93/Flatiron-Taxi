class Driver < ActiveRecord::Base

	def accept_ride(ride)
		ride.update(driver: self)
		puts "Accepted ride!"
	end

	def profits
		Ride.all.select do |r|
			r.driver == self
		end.map {|r| r.fare}.inject(:+)
	end

	def average_rating 
	total =	Ride.all.select do |r|
			r.driver == self && r.rating != nil
		end.map {|r| r.rating} 
		total.inject(:+) / total.length
	end
end