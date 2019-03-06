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
    ans = PromptUtil.prompt('Would you like to request a ride (REQ) or view your most recent rides (REC)?').downcase 
    if ans == 'req'
      run_request_prompt(p)
    elsif ans == 'rec'
      run_view_recents(p)
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
end