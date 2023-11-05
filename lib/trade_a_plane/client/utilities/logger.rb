

require_relative './constant'

module TradeAPlane
  module Client
    class Logger
      def self.info(message:)
        puts "[#{Time.now.utc}] TradeAPlane::Client::Logger - #{message}"
      end
    end
  end
end
