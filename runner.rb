require_relative './config/environment'

def start
	puts "Welcome to Flatiron Taxi! Please enter your phone number."

	num = gets.chomp

	p = Passenger.find_or_create_by(phone_num: num)
		if p.name == nil
			puts "Please enter your name"
			p.update(name: gets.chomp)
		end

	main_menu(p)
end

def runRequestPrompt(p)
	puts "Where is your pick-up location?"
	pickup = gets.chomp
	puts "Where is your drop-off location?"
	dropoff = gets.chomp 
	p.request_ride(pickup, dropoff, fare = 10)
	puts "Your ride has been created."
end

def runViewRecents(p)
	puts "Your recent rides:"
	p.recent_rides.each do |r|
		puts "Date: #{r.created_at}"
		puts "Pick-Up Location: #{r.pickup_loc}"
		puts "Drop-off Location: #{r.dropoff_loc}"
		puts "Fare: #{r.fare}"
		puts "--------------------------"
	end
	main_menu(p)
end

def main_menu(p)
	puts "Would you like to request a ride (REQ) or view your most recent rides (REC)?"

	ans = gets.chomp 
		if ans == "REQ"
			runRequestPrompt(p)
		else 
			runViewRecents(p)
		end
end



start



