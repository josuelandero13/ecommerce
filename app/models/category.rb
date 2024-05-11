# frozen_string_literal: true

# This class allows you to establish categories for products
class Category < ApplicationRecord
  validates :name, presence: true

  has_many :products, dependent: :restrict_with_exception
end
