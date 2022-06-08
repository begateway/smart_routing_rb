module SmartRouting
  class User
    class FlowRule

      attr_reader :client

      def initialize(client, flow_id:)
        @client = client
        @flow_id = flow_id
      end

      def create(params)
        SmartRouting::Response.new client.request(:post, resource_path, { rule: params })
      end

      def update(id, params)
        SmartRouting::Response.new client.request(:put, resource_path(id), { rule: params })
      end

      def delete(id)
        SmartRouting::Response.new client.request(:delete, resource_path(id))
      end

      def get(id)
        SmartRouting::Response.new client.request(:get, resource_path(id))
      end

      def all
        SmartRouting::Response.new client.request(:get, resource_path)
      end

      private

      def resource_path(id = nil)
        "/api/user/flows/#{@flow_id}/rules".tap do |path|
          path << "/#{id}" if id
        end
      end
    end
  end
end
