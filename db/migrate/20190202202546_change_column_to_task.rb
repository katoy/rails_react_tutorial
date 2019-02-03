# frozen_string_literal: true

class ChangeColumnToTask < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :title, :string, limit: 256, null: false
    change_column :tasks, :description, :string, limit: 1024, null: false
  end

  def down
    change_column :tasks, :title, :string
    change_column :tasks, :description, :string
  end
end
