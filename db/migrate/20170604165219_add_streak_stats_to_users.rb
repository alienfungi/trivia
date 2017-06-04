class AddStreakStatsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :longest_correct_streak, :integer, null: false, default: 0
    add_column :users, :longest_incorrect_streak, :integer, null: false, default: 0
    add_column :users, :current_correct_streak, :integer, null: false, default: 0
    add_column :users, :current_incorrect_streak, :integer, null: false, default: 0
    add_column :users, :total_correct_answers, :integer, null: false, default: 0
    add_column :users, :total_incorrect_answers, :integer, null: false, default: 0
  end
end
