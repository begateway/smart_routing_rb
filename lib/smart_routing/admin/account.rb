module SmartRouting
  class Admin
    class Account

      attr_reader :client

      def initialize(client)
        @client = client
      end

      def create(params)
        SmartRouting::Response.new client.request(:post, resource_path, {account: params})
      end

      def update(id, params)
        SmartRouting::Response.new client.request(:put, resource_path(id), {account: params})
      end

      def get(id)
        SmartRouting::Response.new client.request(:get, resource_path(id))
      end

      private
      def resource_path(id = nil)
        "/api/admin/accounts".tap do |path|
          path << "/#{id}" if id
        end
      end

    end
  end
end
