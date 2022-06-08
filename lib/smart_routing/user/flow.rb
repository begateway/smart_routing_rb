module SmartRouting
  class User
    class Flow

      attr_reader :client

      def initialize(client)
        @client = client
      end

      def create(params)
        SmartRouting::Response.new client.request(:post, resource_path, { flow: params })
      end

      def update(id, params)
        SmartRouting::Response.new client.request(:put, resource_path(id), { flow: params })
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

      def verify(params)
        SmartRouting::Response.new client.request(:post,
                                                  resource_path + '/verify',
                                                  data: {
                                                    fields: params[:fields],
                                                    allowable_return_values: params[:allowable_return_values]
                                                  })
      end

      private

      def resource_path(id = nil)
        '/api/user/flows'.tap do |path|
          path << "/#{id}" if id
        end
      end
    end
  end
end
