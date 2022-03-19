class ChangeAnswerIndex2 < ActiveRecord::Migration[5.2]
  def up
    remove_index :answers,   [:user_id, :problem_id]
  end

  def down
    add_index :answers,   [:user_id, :problem_id], unique: true
  end
end
