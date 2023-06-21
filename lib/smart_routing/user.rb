require_relative "user/rule"
require_relative "user/set"
require_relative "user/data"
require_relative "user/object"
require_relative "user/object_type"
require_relative "user/ai"
require_relative 'user/flow'
require_relative 'user/flow_rule'
require_relative 'user/wbl/base'
require_relative 'user/wbl/black_lists'
require_relative 'user/wbl/white_lists'
require_relative 'user/wbl/united'

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

    def ai
      @ai ||= User::AI.new(self)
    end

    def flow
      @flow ||= User::Flow.new(self)
    end

    def flow_rule(flow_id)
      @flow_rule ||= Hash.new do |hash, key|
        hash[key] = User::FlowRule.new(self, flow_id: key)
      end
      @flow_rule[flow_id]
    end

    def white_lists
      @white_lists ||= User::Wbl::WhiteLists.new(self)
    end

    def black_lists
      @black_lists ||= User::Wbl::BlackLists.new(self)
    end

    def wb_lists
      @wb_lists ||= User::Wbl::United.new(self)
    end
  end
end
