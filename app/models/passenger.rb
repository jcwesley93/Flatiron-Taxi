class Passenger < ActiveRecord::Base
  def request_ride(pick_up, drop_off, fare)
    Ride.create(passenger: self,
                pickup_loc: pick_up,
                dropoff_loc: drop_off,
                fare: fare)
  end

  def recent_rides
    Ride.where(passenger_id: id)
    # Ride.all.select { |r| r.passenger == self }
  end

  def wallets
    Wallet.where(passenger_id: id)
    # Wallet.all.select {|w| w.passenger == self}
  end


  def add_payment_method(card_num, exp_date, zip, cvv, cardholder)
    Wallet.create(card_number: card_num, exp_date: exp_date, zip_code: zip, cvv: cvv, cardholder_name: cardholder, passenger_id: self.id)
  end


  def delete_payment_method(num) #pass through the last 4 digits of the card.
  	card = wallets.find { |w| w.card_number[w.card_number.length - 4, w.card_number.length] == num}
  	Wallet.destroy(card.id)
  end

end
