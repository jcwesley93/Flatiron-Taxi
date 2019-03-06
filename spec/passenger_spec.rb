require_relative 'spec_helper'

describe Passenger do
  after(:each) do
    Passenger.destroy_all
  end


  describe 'attributes' do
    it 'has data attributes from a migration file' do
      joshua = Passenger.create(name: 'Josh RS', phone_num: '347 000 1111')
      expect(joshua.name).to eq('Josh RS')
      expect(joshua.phone_num).to eq('347 000 1111')
    end
  end

  describe 'request_ride' do
    it 'requests a ride as a passenger' do
      joshua = Passenger.create(name: 'Josh RS', phone_num: '347 000 1111')
      ride = joshua.request_ride('1000 Fake Pl.', '2000 Real St.', 20)
      expect(ride.passenger).to eq(joshua)
      expect(ride.pickup_loc).to eq('1000 Fake Pl.')
      expect(ride.dropoff_loc).to eq('2000 Real St.')
      expect(ride.fare).to eq(20)
    end
  end

  describe 'recent_rides' do
    it 'shows passenger\'s past rides' do
      joshua = Passenger.create(name: 'Josh RS', phone_num: '347 000 1111')
      ride1 = joshua.request_ride('1000 Fake Pl.', '2000 Real St.', 20)
      ride2 = joshua.request_ride('2332 Fake Pl.', '3489 Real St.', 8)

      expect(joshua.recent_rides).to include(ride1, ride2)
    end
  end

end