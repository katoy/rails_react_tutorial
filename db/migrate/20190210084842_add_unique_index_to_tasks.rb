# frozen_string_literal: true

class AddUniqueIndexToTasks < ActiveRecord::Migration[5.2]
  def up
    add_index :tasks, %i[title description], unique: true
  end

  def down
    remove_index :tasks, %i[title description]
  end
end
