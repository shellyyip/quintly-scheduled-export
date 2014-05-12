class RemoveCronFromQuintlyWorkers < ActiveRecord::Migration
  def change
    remove_column :quintly_workers, :cron, :string
  end
end
