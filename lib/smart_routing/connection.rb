require "faraday"
require "faraday_middleware"
require "smart_routing/middleware"

module SmartRouting
  module Connection

    Faraday::Request.register_middleware request_logger: Middleware::RequestLogger
    Faraday::Response.register_middleware response_logger: Middleware::ResponseLogger
    Faraday::Response.register_middleware parse_json: Middleware::ParseJson

    def request(method, path, params = nil)
      connection.public_send(method, path, params) do |request|
        if [:put, :post].include?(method)
          request.headers['Content-Type'] = 'application/json'
          request.body = params.to_json if params
        end
        request.options.timeout = SmartRouting.read_timeout if SmartRouting.read_timeout
        request.options.open_timeout = SmartRouting.open_timeout if SmartRouting.open_timeout
      end
    rescue Faraday::Error => e
      response = OpenStruct.new(status: 500, body: error_body(e.to_s))
      Response.new(response)
    end

    def connection
      @connection ||=
        begin
          connection = Faraday.new(url: SmartRouting.api_host, proxy: SmartRouting.proxy)

          connection.basic_auth(auth_login, auth_password) if auth_login
          connection.request :json
          connection.request :request_logger
          connection.response :parse_json
          connection.response :response_logger

          connection
        end
    end

    def error_body(message)
      {
        "error" => {
          "code" => "faraday_error",
          "message" => message
        }
      }
    end

  end
end
