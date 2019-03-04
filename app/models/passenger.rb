class Passenger < ActiveRecord::Base

	def request_ride(pick_up, drop_off, fare)
		Ride.create(passenger: self, pickup_loc: pick_up, dropoff_loc: drop_off, fare: fare)
	end

	def recent_rides
		Ride.all.select {|r| r.passenger == self}
	end


end
