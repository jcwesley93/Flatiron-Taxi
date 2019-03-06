# Driver Model
class Driver < ActiveRecord::Base
  def accept_ride(ride)
    ride.update(driver: self)
  end

  def completed_rides
    Ride.all.select { |ride| ride.driver == self }
  end

  def profits
    completed_rides.map(&:fare).inject(:+)
  end

  def average_rating
    # Map the completed rides to their ratings and remove
    # all nil values from the array
    total = completed_rides.map(&:rating).compact
    total.inject(:+) / total.length
  end
end
