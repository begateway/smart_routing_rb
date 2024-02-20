module SmartRouting
  class User
    class Set

      attr_reader :client

      def initialize(client)
        @client = client
      end

      def create(params)
        SmartRouting::Response.new client.request(:post, resource_path, {set: params})
      end

      def update(id, params)
        SmartRouting::Response.new client.request(:put, resource_path(id), {set: params})
      end

      def get(id)
        SmartRouting::Response.new client.request(:get, resource_path(id))
      end

      def all
        SmartRouting::Response.new client.request(:get, resource_path)
      end

      def import(id, params)
        SmartRouting::Response.new client.request(:post, import_path(id), {set: params})
      end

      private
      def resource_path(id = nil)
        "/api/user/sets".tap do |path|
          path << "/#{id}" if id
        end
      end

      def import_path(id)
         resource_path(id) + "/import"
      end

    end
  end
end
