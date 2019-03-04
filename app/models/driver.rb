class Driver < ActiveRecord::Base
  def accept_ride(ride)
    ride.update(driver: self)
    puts 'Accepted ride!'
  end

  def completed_rides
    Ride.all.select { |ride| ride.driver == self }
  end

  def rides_with_ratings
    completed_rides.reject { |ride| ride.rating.nil? }
  end

  def profits
    completed_rides.map(&:fare).inject(:+)
  end

  def average_rating
    total =	rides_with_ratings.map(&:rating)
    total.inject(:+) / total.length
  end
end