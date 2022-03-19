class ChangeAnswerIndex < ActiveRecord::Migration[5.2]
  def up
    add_index :answers, :problem_id
    remove_index :answers,   [:user_id, :problem_id]
  end

  def down
    add_index :answers,   [:user_id, :problem_id]
  end
end
