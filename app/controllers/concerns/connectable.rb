module Concerns::Connectable
  extend ActiveSupport::Concern

  def connection(base_url)
    @conn ||= Faraday.new(url: base_url) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.response :logger
      faraday.use FaradayMiddleware::ParseJson
    end
  end

  private

end