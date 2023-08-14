module SmartRouting
  class User::Wbl::United
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def exists(params)
      SmartRouting::Response.new client.request(:get, resource_path << '/exists', params)
    end

    private

    def resource_path
      "/api/user/white-black-list"
    end
  end
end
