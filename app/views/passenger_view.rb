module PassengerView
  def self.passenger_start
    num = PromptUtil.prompt('Welcome to Flatiron Taxi! Please enter your phone number.')
    p = Passenger.find_or_create_by(phone_num: num)
    if p.name.nil?
      name = PromptUtil.prompt('Please enter your name')
      p.update(name: name)
    end
  
    main_menu_passenger(p)
  end

  def self.main_menu_passenger(p)
    ans = PromptUtil.prompt('Would you like to request a ride (REQ), view your most recent rides (REC), or add a payment method (PAY)?').downcase 
    if ans == 'req'
      run_request_prompt(p)
    elsif ans == 'rec'
      run_view_recents(p)
    elsif ans == 'pay'
      run_view_payment(p)
    else
      main_menu_passenger(p)
    end
  end

  def self.run_request_prompt(p)
    pickup =  PromptUtil.prompt('What is your pick-up location?')
    dropoff =  PromptUtil.prompt('What is your drop-off location?')
    ride = p.request_ride(pickup, dropoff, 10)
    puts 'Your ride has been requested.'
    puts '============================='
    puts 'Some time passes.....'
    puts '============================='
    puts 'Trip Complete!'
    rating = PromptUtil.prompt('How would you rate your driver?')
    ride.rating = rating
    puts "You gave your driver #{rating} stars."
    main_menu_passenger(p)
  end
  
  def self.run_view_recents(p)
    if p.recent_rides.empty?
      puts 'You haven\'t taken any rides.'
    else
      puts 'Your recent rides:'
      p.recent_rides.each do |r|
        puts "Date: #{r.created_at}"
        puts "Pick-Up Location: #{r.pickup_loc}"
        puts "Drop-off Location: #{r.dropoff_loc}"
        puts "Fare: #{r.fare}"
        puts '--------------------------'
      end
    end
    main_menu_passenger(p)
  end


  def self.run_view_payment(p)
    ans =  PromptUtil.prompt("Would you like to view all your payment methods (VIEW), add a card (ADD), or delete a card (DELETE)?").downcase


    if ans == "view"
      if p.view_wallets.empty? 
          puts "You have no linked cards"
        else 
          p.view_wallets.each do |w|
        puts "Card Number: #{w.card_number[w.card_number.length - 4, w.card_number.length]}"
        puts "Exp. Date: #{w.exp_date}"
        puts "Cardholder: #{w.cardholder_name}"
        puts '--------------------------'
        end
        end
      main_menu_passenger(p)
    elsif ans == "add"
      card_number = PromptUtil.prompt("Enter a card number")
      exp_date = PromptUtil.prompt("Enter the card expiration number")
      zip_code = PromptUtil.prompt("Enter your zip code")
      cvv = PromptUtil.prompt("Enter the CVV (Numbers on the back)")
      cardholder_name = PromptUtil.prompt("Enter the cardholder's name")
      p.add_payment_method(card_number, exp_date, zip_code, cvv, cardholder_name)
      puts "Card Added!"
      main_menu_passenger(p)
    elsif  ans == "delete"
      card = PromptUtil.prompt("Please enter the last four digits of the card that you would like to delete")
      p.delete_payment_method(card)
      puts "Card has been deleted!"
      main_menu_passenger(p)
    else
      main_menu_passenger(p)
        
    end
  end




end