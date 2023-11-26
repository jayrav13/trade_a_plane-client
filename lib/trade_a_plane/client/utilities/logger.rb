

require_relative './constant'

module TradeAPlane
  module Client
    class Logger
      def self.logger(message: 'An error has occurred.', level: :info)
        puts "[#{Time.now.utc}] [#{level.upcase}] #{message}"
      end

      def self.info(message); self.logger('INFO', message); end
      def self.warn(message); self.logger('warn', message); end
    end
  end
end
