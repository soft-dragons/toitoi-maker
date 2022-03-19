class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :user_id, null: false
      t.integer :problem_id, null: false
      t.boolean :result, null: false, default: false

      t.timestamps
    end

    add_index :answers, :user_id,    unique: true
    add_index :answers, :problem_id, unique: true
  end
end
