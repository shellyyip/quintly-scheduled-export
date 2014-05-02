class CreateQuintlyWorkers < ActiveRecord::Migration
  def change
    create_table :quintly_workers do |t|
      t.integer :subscription_id
      t.string :cron
      t.string :quintly_metric
      t.string :quintly_period
      t.string :quintly_interval
      t.string :quintly_profileids

      t.timestamps
    end
    add_index :quintly_workers, :subscription_id
  end
end