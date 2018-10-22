module SmartRouting
  class User
    class Rule

      attr_reader :client

      def initialize(client)
        @client = client
      end

      def verify(params)
        SmartRouting::Response.new client.request(:post, resource_path + "/verify", {fields: params})
      end

      private
      def resource_path(id = nil)
        "/api/user/rules".tap do |path|
          path << "/#{id}" if id
        end
      end

    end
  end
end
