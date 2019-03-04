require_relative './config/environment'

def general_main_menu
  puts 'Are you a passenger (P) or driver (D)?'
  answer = gets.chomp
  if answer == 'P'
    passenger_start
  else
    driver_start
  end
end

def prompt_for_number
  puts 'Welcome to Flatiron Taxi! Please enter your phone number.'
  gets.chomp
end

def passenger_start
  num = prompt_for_number

  p = Passenger.find_or_create_by(phone_num: num)
  if p.name.nil?
    puts 'Please enter your name'
    p.update(name: gets.chomp)
  end

  main_menu_passenger(p)
end

def driver_start
  num = prompt_for_number

  d = Driver.find_or_create_by(phone_num: num)
  if d.name.nil?
    puts 'Please enter your name'
    d.update(name: gets.chomp)
  end

  main_menu_driver(d)
end

def run_request_prompt(p)
  puts 'Where is your pick-up location?'
  pickup = gets.chomp
  puts 'Where is your drop-off location?'
  dropoff = gets.chomp 
  p.request_ride(pickup, dropoff, 10)
  puts 'Your ride has been created.'
end

def run_view_recents(p)
  if p.recent_rides.empty?
    puts "You haven't taken any rides."
  elsif
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

def show_pending_rides(driver)
  if Ride.rides_without_driver.empty?
    puts 'There are no nearby rides :('
    return
  end

  Ride.rides_without_driver.each do |r|
    puts "Pick-Up Location: #{r.pickup_loc}"
    puts "Drop-off Location: #{r.dropoff_loc}"
    puts "Fare: #{r.fare}"
    puts '--------------------------'
    puts 'Would you like to accept this ride? (y/n)'
    answer = gets.chomp
    if answer == 'y'
      r.rating = rand(1..5)
      driver.accept_ride(r)
      break;
    end
  end
end

def main_menu_passenger(p)
  puts 'Would you like to request a ride (REQ) or view your most recent rides (REC)?'

  ans = gets.chomp 
  if ans == 'REQ'
    run_request_prompt(p)
  elsif ans == 'REC'
    run_view_recents(p)
  end
end

def main_menu_driver(d)
  puts 'Would you like to view nearby rides (RIDE), view your profits ($), or view your rating (RATE)?'
  answer = gets.chomp 
  if answer == 'RIDE'
    show_pending_rides(d)
  elsif answer == '$'
    puts "Your profits are #{d.profits}"
    main_menu_driver(d)
  else
    puts "Your average rating is #{d.average_rating}"
    main_menu_driver(d)
  end
end

general_main_menu
