module SmartRouting
  class User
    class AI
      def verify(params)
        SmartRouting::Response.new client.request(
          :post,
          "/api/user/ai/verify",
          data: {
            fields: params[:fields],
            allowable_return_values: params[:allowable_return_values]
          }
        )
      end
    end
  end
end
