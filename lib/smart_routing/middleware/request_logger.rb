module SmartRouting
  module Middleware
    class RequestLogger < Faraday::Middleware
      include ::SmartRouting::Middleware::Helpers

      def call(env)
        if logger = SmartRouting.logger
          logger.info("Request: start #{env.method.upcase} to #{env.url}#{request_id_msg(env)}")
          logger.info( SmartRouting::LogSanitizer.sanitize(env.body) + request_id_msg(env) ) if env.body
        end
        @app.call(env)
      end

    end
  end
end
