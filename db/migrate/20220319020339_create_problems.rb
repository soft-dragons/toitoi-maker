class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :statement, null: false
      t.string :answer, null: false
      t.string :incorrect1, null: false
      t.string :incorrect2, null: false

      t.timestamps
    end
  end
end
