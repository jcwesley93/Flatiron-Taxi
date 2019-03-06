require 'rake'
require 'active_record'
require 'yaml/store'
require 'ostruct'
require 'date'

require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/flatirontaxi.sqlite'
)

require_relative '../app/models/wallet.rb'
require_relative '../app/models/passenger.rb'
require_relative '../app/models/ride.rb'
require_relative '../app/models/driver.rb'

require_relative '../app/views/prompt_util.rb'
require_relative '../app/views/main_menu_view.rb'
require_relative '../app/views/driver_view.rb'
require_relative '../app/views/passenger_view.rb'
