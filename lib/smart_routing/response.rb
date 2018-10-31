module SmartRouting
  class Response

    attr_reader :response

    def initialize(response)
      @response = response
    end

    def status
      response.status
    end

    def success?
      (200..299).include?(status) ? true : false
    end

    def error?
      !success?
    end

    def data
      @data ||= begin
                  if body["data"].is_a?(Array)
                    prepare_collection(body["data"])
                  else
                    OpenStruct.new(body["data"])
                  end
                end
    end

    def error
      @error ||= OpenStruct.new(body["error"])
    end

    def raw
      body["raw_response"] || body.to_json
    end

    protected
    def body
      @body ||= response.body.is_a?(Hash) ? response.body : {}
    end

    def prepare_collection(collection)
      [].tap do |result|
        collection.each {|element| result << OpenStruct.new(element)}
      end
    end

  end
end
