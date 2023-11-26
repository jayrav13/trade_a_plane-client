# frozen_string_literal: true

require_relative "utilities/version"
require_relative "utilities/constant"
require_relative "utilities/logger"
require_relative "base"

module TradeAPlane
  module Client
    # class Listing
    class Listing < TradeAPlane::Client::Base
      attr_reader :id, :data

      def initialize(id:)
        raise InvalidIdentifierError, "id cannot be 'nil'." if id.nil?
        raise InvalidIdentifierError, "id must be an integer value." if id.to_i.to_s != id.to_s

        @id = id
      end

      def as_json
        {
          title: get_title,
          price: anchor.xpath('//p[@class="price"]/span[@itemprop="price"]').first.text.to_i,
          info: anchor.xpath('//div[@id="info-list-seller"]')
        }
      end

      # Fetch the "title" of a Trade-A-Plane listing.
      #
      # Example: 1963 BEECHCRAFT P35 BONANZA
      def get_title
        begin
          titles = anchor.xpath('//h1[@id="header"]')
          if titles.count > 1
            logger(message: "Multiple header elements identified. Selecting the first one.", level: :warn)
          end
          titles.first&.text&.strip
        rescue StandardError => e

        end
      end

      def get_price
        anchor.xpath('//p[@class="price"]/span[@itemprop="price"]').first.text.to_i
      end

      def anchor
        @anchor ||= Nokogiri::HTML(fetch.body)
      end

      def fetch
        @fetch ||= request(params: {listing_id: @id})
      end

      def logger(message:, level: :info)
        TradeAPlane::Client::Logger.public_send(level, "[listing_id:#{id}] #{message}")
      end
    end

    # Errors
    class InvalidIdentifierError < StandardError; end
  end
end
