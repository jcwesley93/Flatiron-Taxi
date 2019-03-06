module DriverView
  def self.driver_start
    num = PromptUtil.prompt('Welcome to Flatiron Taxi! Please enter your phone number.')
  
    d = Driver.find_or_create_by(phone_num: num)
    if d.name.nil?
      puts 'Please enter your name'
      d.update(name: gets.chomp)
    end
  
    main_menu_driver(d)
  end

  def self.show_pending_rides(driver)
    if Ride.rides_without_driver.empty?
      puts 'There are no nearby rides :('
      return
    end
  
    Ride.rides_without_driver.each do |r|
      puts "Pick-Up Location: #{r.pickup_loc}"
      puts "Drop-off Location: #{r.dropoff_loc}"
      puts "Fare: #{r.fare}"
      puts '--------------------------'
      answer = PromptUtil.prompt('Would you like to accept this ride? (y/n)')
      if answer == 'y'
        r.rating = rand(1..5)
        driver.accept_ride(r)
        break;
      end
    end
  end

  def self.main_menu_driver(d)
    answer = PromptUtil.prompt('Would you like to view nearby rides (RIDE), view your profits ($), or view your rating (RATE)?').downcase
    if answer == 'ride'
      show_pending_rides(d)
    elsif answer == '$'
      puts "Your profits are #{d.profits}"
      main_menu_driver(d)
    elsif answer == 'rate'
      puts "Your average rating is #{d.average_rating}"
      main_menu_driver(d)
    else
      main_menu_driver(d)
    end
  end
end