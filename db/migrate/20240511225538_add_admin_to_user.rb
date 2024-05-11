# frozen_string_literal: true

# Add admin column to users table
class AddAdminToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin, :boolean, default: false
  end
end
