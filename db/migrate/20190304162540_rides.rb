class Rides < ActiveRecord::Migration[5.2]
  def change
  	create_table :rides do |t|
  		t.integer :passenger_id
  		t.integer :driver_id
  		t.string :pickup_loc
  		t.string :dropoff_loc
  		t.integer :fare
  		t.float :rating
  		t.timestamps
  	end
  end
end
