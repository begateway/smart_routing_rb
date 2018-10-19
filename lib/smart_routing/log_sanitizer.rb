module SmartRouting
  class LogSanitizer

    attr_reader :body

    def self.sanitize(body)
      new(body).filter_token
    end

    def initialize(body)
      @body = body
    end

    def filter_token
      body.gsub(/token"[^"].*?"([^"]{5})[^"].*?([^"]{5})"/, 'token":"\1*****\2"')
    end

  end
end
