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
        request.headers.update(headers) if headers

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
          connection = Faraday.new(url: SmartRouting.api_host, proxy: SmartRouting.proxy) do |conn|
            conn.basic_auth(auth_login, auth_password) if auth_login
            conn.request :json
            conn.request :request_logger
            conn.response :parse_json
            conn.response :response_logger

            conn.adapter Faraday.default_adapter
          end

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
