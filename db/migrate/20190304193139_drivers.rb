class Drivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :phone_num
      t.string :license
    end
  end
end
