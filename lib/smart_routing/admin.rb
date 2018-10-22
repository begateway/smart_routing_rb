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
