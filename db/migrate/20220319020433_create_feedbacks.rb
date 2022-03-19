class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.integer :user_id, null: false
      t.integer :problem_id, null: false
      t.text :text, null: false

      t.timestamps
    end

    add_index :feedbacks, :user_id,    unique: true
    add_index :feedbacks, :problem_id, unique: true
  end
end
