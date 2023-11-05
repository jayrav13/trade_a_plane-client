# frozen_string_literal: true

require_relative "utilities/version"
require_relative "utilities/constant"
require_relative "utilities/logger"

module TradeAPlane
  module Client
    # class Listing
    class Listing
      attr_reader :id, :listing

      def initialize(id:)
        raise InvalidIdentifierError, "id cannot be 'nil'." if id.nil?
        raise InvalidIdentifierError, "id must be an integer value." if id.to_i.to_s != id.to_s

        @id = id
        @base_uri = TradeAPlane::Client::SEARCH_URL
      end

      def as_json
        {
          title: anchor.xpath('//h1[@id="header"]').first.text.trim,
          price: anchor.xpath('//p[@class="price"]/span[@itemprop="price"]').first.text.to_i,
          info: anchor.xpath('//div[@id="info-list-seller"]')
        }
      end

      private

      def anchor
        @listing ||= fetch
        @anchor ||= Nokogiri::HTML(@listing.body)
        @anchor
      end

      def fetch
        uri = @base_uri + "?listing_id=#{@id}"
        TradeAPlane::Client::Logger.info(message: "Beginning fetch for id #{@id} - #{uri}")
        request = Typhoeus::Request.new(uri, method: :get, followlocation: true)
        response = request.run
        TradeAPlane::Client::Logger.info(message: "Request for id #{@id} completed with status code #{response.code}.")
        response
      end
    end

    class InvalidIdentifierError < StandardError; end
  end
end
