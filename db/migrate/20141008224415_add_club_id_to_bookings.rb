class AddClubIdToBookings < ActiveRecord::Migration
  def change
  	add_column :bookings, :club_id, :integer
  end
end
