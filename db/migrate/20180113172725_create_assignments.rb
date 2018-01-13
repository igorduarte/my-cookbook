class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.integer :user_id
      t.integer :role_id
    end
    add_index :assignments, :user_id
    add_index :assignments, :role_id
  end
end
