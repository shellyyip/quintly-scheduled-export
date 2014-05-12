class RemoveFrequencyFromSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :frequency, :string
  end
end
