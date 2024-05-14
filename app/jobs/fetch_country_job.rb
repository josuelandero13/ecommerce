# frozen_string_literal: true

# ActiveJob for the request to the API that obtains the user's country
class FetchCountryJob < ApplicationJob
  queue_as :default

  def perform(user_id, ip)
    update_user_country(user_id, ip)
  end

  private

  def update_user_country(user_id, ip)
    return unless FetchCountryService.new(ip).fetch_country_code

    user = User.find(user_id)
    user.update(country: country)
  end
end
