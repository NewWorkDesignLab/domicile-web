class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.belongs_to :scenario
      t.belongs_to :user

      t.timestamps
    end

    add_reference :scenarios, :user, index: true
  end
end
