module DriverView
  def self.driver_start(prompt)
    num = prompt.ask('What is your phone number?')

    d = Driver.find_or_create_by(phone_num: num)
    if d.name.nil?
      puts 'Please enter your name'
      d.update(name: gets.chomp)
    end
  
    main_menu_driver(d, prompt)
  end

  def self.display_ride(ride)
    puts "Pick-Up Location: #{ride.pickup_loc}"
    puts "Drop-off Location: #{ride.dropoff_loc}"
    puts "Fare: #{ride.fare}"
    puts '--------------------------'
  end

  def self.show_pending_rides(driver, prompt)
    if Ride.rides_without_driver.empty?
      puts 'There are no nearby rides :('
      return
    end

    Ride.rides_without_driver.each do |r|
      display_ride(r)
      answer = prompt.yes?('Do you want to accept this ride?') do |q|
        q.default 'y'
        q.positive 'y'
        q.negative 'n'
      end
      puts "Answer: #{answer}"
      if answer
        driver.accept_ride(r)
        main_menu_driver(driver, prompt)
      end
    end
  end

  def self.main_menu_driver(d, prompt)
    ans = prompt.select('What would you like to do?') do |menu|
      menu.choice 'View Nearby Rides', 1
      menu.choice 'View Your Profits', 2
      menu.choice 'View Your Rating', 3
    end

    case ans
    when 1
      show_pending_rides(d, prompt)
    when 2
      puts "Your profits are #{d.profits}"
    when 3
      puts "Your average rating is #{d.average_rating}"
    end
    main_menu_driver(d, prompt)
  end
end
