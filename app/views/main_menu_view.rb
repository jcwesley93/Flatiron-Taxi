module MainMenuView
  @@prompt = TTY::Prompt.new

  def self.general_main_menu

    answer = @@prompt.select('Are you a passenger or a driver?', %w[Passenger Driver])
    if answer == 'Passenger'
      PassengerView.passenger_start(@@prompt)
    elsif answer == 'Driver'
      DriverView.driver_start(@@prompt)
    else
      general_main_menu
    end
  end
end