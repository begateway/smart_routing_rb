require_relative "user/rule"

module SmartRouting
  class User
    include Connection

    attr_reader :auth_login, :auth_password

    def initialize(options)
      @auth_login = options[:auth_login]
      @auth_password = options[:auth_password]
    end

    def rule
      @rule ||= User::Rule.new(self)
    end

  end
end
