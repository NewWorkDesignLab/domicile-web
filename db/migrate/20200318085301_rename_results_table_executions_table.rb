class RenameResultsTableExecutionsTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :results, :executions
  end
end
