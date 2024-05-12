# frozen_string_literal: true

# Category protection policy
class CategoryPolicy < BasePolicy
  def method_missing(m, *args, &block)
    Current.user.admin?
  end
end
