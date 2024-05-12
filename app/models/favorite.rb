# frozen_string_literal: true

# Model to add favorite products and link with users and products
class Favorite < ApplicationRecord
  validates :user, uniqueness: { scope: :product }

  belongs_to :user
  belongs_to :product
end
