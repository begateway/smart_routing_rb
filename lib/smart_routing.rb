require "smart_routing/version"

require "smart_routing/response"
require "smart_routing/connection"
require "smart_routing/admin"

module SmartRouting

  @api_host = "https://api.smart-routing.ecomcharge.com"

  @logger = nil

  @open_timeout = 20
  @read_timeout = 40

  @proxy = nil

  class << self
    attr_accessor :api_host, :logger, :open_timeout, :read_timeout, :proxy
  end
end
