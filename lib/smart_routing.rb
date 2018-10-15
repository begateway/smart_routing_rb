require "smart_routing/version"

module SmartRouting

  @api_host = "https://api.smart-routing.ecomcharge.com"

  @logger = nil

  @open_tomeout = 20
  @read_tomeout = 40

  @proxy = nil

  class << self
    attr_accessor :api_host, :logger, :open_tomeout, :read_tomeout, :proxy
  end
end
