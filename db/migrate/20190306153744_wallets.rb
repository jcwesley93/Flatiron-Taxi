class Wallets < ActiveRecord::Migration[5.2]
  def change
  	create_table :wallets do |t|
  		t.string :card_number
  		t.string :exp_date
  		t.integer :zip_code
  		t.integer :cvv
  		t.string :cardholder_name
  		t.integer :passenger_id
  	end

  end
end
