class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :milestone
      t.string :description
      t.timestamps
    end
  end
end
