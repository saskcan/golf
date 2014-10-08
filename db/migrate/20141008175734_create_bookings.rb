class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.datetime :time

      t.timestamps
    end
  end
end
