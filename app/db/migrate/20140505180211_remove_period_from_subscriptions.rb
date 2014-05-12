class RemovePeriodFromSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :period, :string
  end
end
