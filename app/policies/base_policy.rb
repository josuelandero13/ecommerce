# frozen_string_literal: true

# Class for a constructor
class BasePolicy
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def method_missing(m, *args, &block)
    false
  end
end
