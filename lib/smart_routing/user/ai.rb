module SmartRouting
  class User
    class AI
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def verify(params)
        SmartRouting::Response.new(
          client.request(
            :post,
            "/api/user/ai/verify",
            data: {
              fields: params[:fields],
              allowable_return_values: params[:allowable_return_values],
              options: params[:options] || {}
            }
          )
        )
      end
    end
  end
end
