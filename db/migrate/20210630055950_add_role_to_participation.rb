class AddRoleToParticipation < ActiveRecord::Migration[6.0]
  def change
    add_column :participations, :role, :integer, default: 0
  end
end
