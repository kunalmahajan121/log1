class AddColToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :otp, :string
    add_column :users, :otp_expiration, :datetime
  end
end
