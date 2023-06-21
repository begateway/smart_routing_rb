module SmartRouting
  class User
    module Wbl
      module Base
        attr_reader :client

        def initialize(client)
          @client = client
        end

        def modify(params)
          SmartRouting::Response.new client.request(:post, resource_path, params)
        end

        def delete(params)
          SmartRouting::Response.new client.request(:delete, resource_path, params)
        end
      end
    end
  end
end