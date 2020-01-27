class CreateScenarios < ActiveRecord::Migration[6.0]
  def change
    create_table :scenarios do |t|

      t.timestamps
    end
  end
end
