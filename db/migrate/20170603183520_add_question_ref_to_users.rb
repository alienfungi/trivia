class AddQuestionRefToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :question, foreign_key: true, index: false
  end
end
