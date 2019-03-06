module DriverView
  def self.driver_start(prompt)
    @@prompt = prompt
    num = @@prompt.ask('What is your phone number?')

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
      answer = @@prompt.yes?("Do you want to accept this ride?") do |q|
        q.default false
        q.positive 'Yup'
        q.negative 'Nope'
      end
      if answer == 'Yup'
        r.rating = rand(1..5)
        driver.accept_ride(r)
        main_menu_driver(driver);
      end
    end
  end

  def self.main_menu_driver(d)
    ans = @@prompt.select('What would you like to do?') do |menu|
      menu.choice 'View Nearby Rides', 1
      menu.choice 'View Your Profits', 2
      menu.choice 'View Your Rating', 3
    end
    if ans == 1
      show_pending_rides(d)
    elsif ans == 2
      puts "Your profits are #{d.profits}"
      main_menu_driver(d)
    elsif ans ==  3
      puts "Your average rating is #{d.average_rating}"
      main_menu_driver(d)
    else
      main_menu_driver(d)
    end
  end
end