class ChangeIndex < ActiveRecord::Migration[5.2]
  def change
    #remove_index :answers,   :problem_id
    remove_index :feedbacks, :problem_id
    #add_index :answers,   [:user_id, :problem_id], unique: true
    add_index :feedbacks, :problem_id
  end
end
