# frozen_string_literal: true

# Migration for add country column in the table users
class AddCountryToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :country, :string
  end
end
