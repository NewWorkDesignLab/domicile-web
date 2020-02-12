class SetupScenarios < ActiveRecord::Migration[6.0]
  def change
    add_column :scenarios, :name, :string
    add_column :scenarios, :password_digest, :string
    add_column :scenarios, :number_rooms, :integer
    add_column :scenarios, :time_limit, :integer
    add_column :scenarios, :number_damages, :integer
  end
end
