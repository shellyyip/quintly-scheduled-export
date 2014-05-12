class CreateQuintlyProfiles < ActiveRecord::Migration
  def change
    create_table :quintly_profiles do |t|
      t.integer :quintly_profile_id
      t.string :company
      t.string :type

      t.timestamps
    end
  end
end
