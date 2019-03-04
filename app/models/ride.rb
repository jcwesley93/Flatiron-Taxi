class Ride < ActiveRecord::Base
  belongs_to :passenger
  belongs_to :driver

  def self.rides_without_driver
    all.select { |r| r.driver_id.nil? }
  end
end
