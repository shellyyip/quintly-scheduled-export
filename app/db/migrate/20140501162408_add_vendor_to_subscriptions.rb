class AddVendorToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :vendor, :string, null: false, after: :email
  end
end
