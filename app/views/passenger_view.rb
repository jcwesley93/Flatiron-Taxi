module PassengerView
  def self.passenger_start(prompt)
    @@prompt = prompt
    num = @@prompt.ask('What is your phone number?')
    p = Passenger.find_or_create_by(phone_num: num)
    if p.name.nil?
      name = @@prompt.ask('What is your name?')
      p.update(name: name)
    end

    main_menu_passenger(p)
  end

  def self.main_menu_passenger(p)
    ans = @@prompt.select('What would you like to do?') do |menu|
      menu.choice 'Request a Ride', 1
      menu.choice 'View Previous Rides', 2
      menu.choice 'Edit Payment Methods', 3
    end
    if ans == 1
      run_request_prompt(p)
    elsif ans == 2
      run_view_recents(p)
    elsif ans == 3
      run_view_payment(p)
    else
      main_menu_passenger(p)
    end
  end

  def self.run_request_prompt(p)
    pickup =  @@prompt.ask('What is your pick-up location?')
    dropoff =  @@prompt.ask('What is your drop-off location?')
    ride = p.request_ride(pickup, dropoff, 10)
    puts 'Your ride has been requested.'
    puts '============================='
    puts 'Some time passes.....'
    puts '============================='
    puts 'Trip Complete!'
    rating = PromptUtil.prompt('How would you rate your driver?')
    ride.rating = @@prompt.slider('Rating', max: 5, step: 1)
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
    ans = @@prompt.select('What would you like to do?') do |menu|
      menu.choice 'View all linked cards', 1
      menu.choice 'Add a card', 2
      menu.choice 'Remove a card', 3
      menu.choice 'Go back', 4
    end
    if ans == 1
      if p.view_wallets.empty? 
        puts 'You have no linked cards'
      else 
        p.view_wallets.each do |w|
          puts "Card Number: #{w.card_number[w.card_number.length - 4, w.card_number.length]}"
          puts "Exp. Date: #{w.exp_date}"
          puts "Cardholder: #{w.cardholder_name}"
          puts '--------------------------'
        end
      end
      main_menu_passenger(p)
    elsif ans == 2
      card_number = @@prompt.ask("Enter a card number")
      exp_date = @@prompt.ask("Enter the card expiration number")
      zip_code = @@prompt.ask("Enter your zip code")
      cvv = @@prompt.ask("Enter the CVV (Numbers on the back)")
      cardholder_name = @@prompt.ask("Enter the cardholder's name")
      p.add_payment_method(card_number, exp_date, zip_code, cvv, cardholder_name)
      puts "Card Added!"
    elsif  ans == 3
      card = @@prompt.ask("Please enter the last four digits of the card that you would like to delete")
      p.delete_payment_method(card)
      puts 'Card has been deleted!'
    end
    main_menu_passenger(p)
  end
end
