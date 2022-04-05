require_relative "user/rule"
require_relative "user/set"
require_relative "user/data"
require_relative "user/object"
require_relative "user/object_type"
require_relative "user/ai"

module SmartRouting
  class User
    include Connection

    attr_reader :auth_login, :auth_password, :headers

    def initialize(options)
      @headers = options[:headers]
      @auth_login = options[:auth_login]
      @auth_password = options[:auth_password]
    end

    def rule
      @rule ||= User::Rule.new(self)
    end

    def set
      @set ||= User::Set.new(self)
    end

    def object_type
      @object_type ||= User::ObjectType.new(self)
    end

    def object
      @object ||= User::Object.new(self)
    end

    def data
      @data ||= User::Data.new(self)
    end

  end
end
