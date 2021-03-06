require "smart_routing/version"

require "smart_routing/log_sanitizer"
require "smart_routing/response"
require "smart_routing/connection"
require "smart_routing/admin"
require "smart_routing/user"

module SmartRouting

  @api_host = "https://api.smart-routing.begateway.com"

  @logger = nil

  @open_timeout = 20
  @read_timeout = 40

  @proxy = nil

  class << self
    attr_accessor :api_host, :logger, :open_timeout, :read_timeout, :proxy
  end
end
