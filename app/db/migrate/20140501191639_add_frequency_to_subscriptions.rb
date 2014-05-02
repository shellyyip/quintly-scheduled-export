class AddFrequencyToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :frequency, :string, null: false, after: :vendor
  end
end
