class ChangePeriodToInteger < ActiveRecord::Migration
  def change
    change_column :quintly_workers, :quintly_period, :integer
  end
end
