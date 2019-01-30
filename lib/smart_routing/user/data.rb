module SmartRouting
  class User
    class Data

      attr_reader :client

      def initialize(client)
        @client = client
      end

      def add(params)
        SmartRouting::Response.new client.request(:post, resource_path, {data: params})
      end

      private
      def resource_path
        "/api/user/data"
      end

    end
  end
end
