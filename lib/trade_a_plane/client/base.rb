# frozen_string_literal: true

require_relative "utilities/version"
require_relative "utilities/constant"

require 'securerandom'
require 'json'

module TradeAPlane
  module Client
    # Base class for all client classes for TradeAPlane.
    class Base
      def request(base_uri: TradeAPlane::Client::BASE_DOMAIN, path: TradeAPlane::Client::SEARCH_PATH, params: {}, method: :get)
        request_uuid = SecureRandom.uuid
        http_logger(request_uuid, "Initiating request: #{method.to_s.upcase} #{base_uri + path} with parameters #{params.to_json}")

        request = Typhoeus::Request.new(
          base_uri + path,
          params: params,
          method: method,
          followlocation: true
        )

        response = request.run
        http_logger(request_uuid, "Response #{response.code}.")
        response
      end

      def http_logger(id:, message:, level: :info)
        TradeAPlane::Client::Logger.public_send(level, "[request_uuid:#{id}] #{message}", level: :info)
      end
    end
  end
end
