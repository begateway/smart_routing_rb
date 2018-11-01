module SmartRouting
  class User
    class Rule

      attr_reader :client

      def initialize(client)
        @client = client
      end

      def create(params)
        SmartRouting::Response.new client.request(:post, resource_path, {rule: params})
      end

      def update(id, params)
        SmartRouting::Response.new client.request(:put, resource_path(id), {rule: params})
      end

      def get(id)
        SmartRouting::Response.new client.request(:get, resource_path(id))
      end

      def all
        SmartRouting::Response.new client.request(:get, resource_path)
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
