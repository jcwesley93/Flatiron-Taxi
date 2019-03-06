require_relative 'spec_helper'

describe Driver do
  after(:each) do
    Driver.destroy_all
  end


  describe 'attributes' do
    it 'has data attributes from a migration file' do
      robert = Driver.create(name: 'Robert Sanchez', phone_num: '646 112 1315')
      expect(robert.name).to eq('Robert Sanchez')
      expect(robert.phone_num).to eq('646 112 1315')
    end
  end

  describe 'profits' do
    it 'returns the driver\'s profit' do
      joshua = Passenger.create(name: 'Josh RS', phone_num: '347 000 1111')
      robert = Driver.create(name: 'Robert Sanchez', phone_num: '646 112 1315')
      ride = joshua.request_ride('1000 Fake Pl.', '2000 Real St.', 20)
      ride.update(driver: robert)

      ride2 = joshua.request_ride('3423 Fake Pl.', '234 Real St.', 11)
      ride2.update(driver: robert)

      expect(robert.profits).to eq(31)
    end
  end

  describe 'average_rating' do
    it 'shows driver\'s average rating from all rides.' do
      joshua = Passenger.create(name: 'Josh RS', phone_num: '347 000 1111')
      robert = Driver.create(name: 'Robert Sanchez', phone_num: '646 112 1315')
      ride = joshua.request_ride('1000 Fake Pl.', '2000 Real St.', 20)
      ride.update(driver: robert)
      ride.update(rating: 5.0)

      ride2 = joshua.request_ride('3423 Fake Pl.', '234 Real St.', 11)
      ride2.update(driver: robert)
      ride2.update(rating: 3.2)

      expect(robert.average_rating).to eq(4.1)
    end
  end

end