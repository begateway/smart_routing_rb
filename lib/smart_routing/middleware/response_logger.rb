module SmartRouting
  module Middleware
    class ResponseLogger < Faraday::Response::Middleware
      include ::SmartRouting::Middleware::Helpers

      def on_complete(response)
        if logger = SmartRouting.logger
          logger.info("Response: status #{response.status} #{response.reason_phrase}#{request_id_msg(response)}")
          logger.info( SmartRouting::LogSanitizer.sanitize(response.body) + request_id_msg(response) )
        end
      end

    end
  end
end
