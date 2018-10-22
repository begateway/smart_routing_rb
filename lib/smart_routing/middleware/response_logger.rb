module SmartRouting
  module Middleware
    class ResponseLogger < Faraday::Response::Middleware

      def on_complete(response)
        if logger = SmartRouting.logger
          logger.info("Response: status #{response.status} #{response.reason_phrase}")
          logger.info( SmartRouting::LogSanitizer.sanitize(response.body) )
        end
      end

    end
  end
end
