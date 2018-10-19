module SmartRouting
  module Middleware
    class RequestLogger < Faraday::Middleware

      def call(env)
        if logger = SmartRouting.logger
          logger.info("Request: start #{env.method.upcase} to #{env.url}")
          logger.info( SmartRouting::LogSanitizer.sanitize(env.body) )  if env.body
        end
        @app.call(env)
      end

    end
  end
end
