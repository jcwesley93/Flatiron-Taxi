# Driver Model
class Driver < ActiveRecord::Base
  has_many :rides
  has_many :passengers, through: :rides
  def accept_ride(ride)
    ride.update(driver_id: id)
  end

  def completed_rides
    Ride.where(driver_id: id)
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
