class AddPeriodToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :period, :string, null: false, after: :vendor
  end
end
