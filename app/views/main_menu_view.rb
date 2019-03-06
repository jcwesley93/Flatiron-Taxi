module MainMenuView
  def self.general_main_menu
    answer = PromptUtil.prompt('Are you a passenger (P) or a driver (D)?')
    if answer == 'P'
      PassengerView.passenger_start
    elsif answer == 'D'
      DriverView.driver_start
    else
      general_main_menu
    end
  end
end