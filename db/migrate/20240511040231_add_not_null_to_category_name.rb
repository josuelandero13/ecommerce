# frozen_string_literal: true

# Constraint for category model name
class AddNotNullToCategoryName < ActiveRecord::Migration[7.1]
  def change
    change_column_null :categories, :name, false
  end
end
