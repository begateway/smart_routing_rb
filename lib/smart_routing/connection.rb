require "faraday"
require "faraday_middleware"
require "smart_routing/middleware"

module SmartRouting
  module Connection

    def request(method, path, params = nil)
      connection.public_send(method, path, path) do |request|
        if method == :post
          request.headers['Content-Type'] = 'application/json'
          request.body = params.to_json if params
        end
        request.options.timeout = SmartRouting.read_timeout if SmartRouting.read_timeout
        request.options.open_timeout = SmartRouting.open_timeout if SmartRouting.open_timeout
      end
    rescue Faraday::Error => e
      response = OpenStruct.new(status: 500, body: error_body(e.to_s))
      Response::Base.new(response)
    end

    def connection
      @connection ||=
        begin
          connection = Faraday.new(url: SmartRouting.api_host, proxy: SmartRouting.proxy)

          connection.basic_auth(auth_login, auth_password) if auth_login
          connection.request :json
          connection.use SmartRouting::Middleware::ParseJson

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
