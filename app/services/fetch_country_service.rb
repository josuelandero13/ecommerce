# frozen_string_literal: true

require 'net/http'

# Class to search for the user's country.
class FetchCountryService
  attr_reader :ip

  def initialize(ip)
    @ip = ip
  end

  def fetch_country_code
    uri = URI("http://ip-api.com/json/#{ip}")
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)

    country_code(parsed_response)
  rescue SocketError => e
    Rails.logger.error "Error al conectar con el servidor de IP-API: #{e.message}"
    nil
  rescue JSON::ParserError => e
    Rails.logger.error "Error al analizar la respuesta JSON: #{e.message}"
    nil
  end

  private

  def country_code(response)
    return unless response.dig('status') == 'success'

    response.dig('countryCode').downcase
  end
end
