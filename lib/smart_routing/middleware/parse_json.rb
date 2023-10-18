require 'faraday'
require 'json'

module SmartRouting
  module Middleware
    class ParseJson < Faraday::Response::Middleware

      def on_complete(response)
        response.body = begin
                          JSON.parse(response.body)
                        rescue JSON::ParserError
                          error_response(response)
                        end
      end

      private

      def error_response(response)
        {
          "error" =>
          { "code"    => "invalid_response",
            "message" => "Response is not JSON. Status is #{response.status}.",
            "raw_response" => response.body
          }
        }
      end
    end

  end
end
