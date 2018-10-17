require_relative "admin/account"

module SmartRouting
  class Admin
    include Connection

    attr_reader :auth_login, :auth_password

    def initialize(options)
      @auth_login = options[:auth_login]
      @auth_password = options[:auth_password]
    end

    def account
      @account ||= Admin::Account.new(self)
    end

  end
end

# SmartRouting.api_host = "http://0.0.0.0:4000"
# client = SmartRouting::Admin.new(auth_login: "admin", auth_password: "bsUHxEMR7pALfzT6gwqNMuWUyaNQ6o8")
# response = client.account.create(name: "Box Shop")
