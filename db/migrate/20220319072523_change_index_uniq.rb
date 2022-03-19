class ChangeIndexUniq < ActiveRecord::Migration[5.2]
  def change
    remove_index :problems,  :user_id
    remove_index :answers,   :user_id
    remove_index :answers,   :problem_id
    remove_index :feedbacks, :user_id
    remove_index :feedbacks, :problem_id
    add_index :problems,  :user_id
    add_index :answers,   :user_id
    add_index :answers,   [:user_id, :problem_id], unique: true
    add_index :feedbacks, :user_id
    add_index :feedbacks, :problem_id
  end
end
