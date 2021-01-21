module SmartRouting
  module Middleware
    module Helpers

      def request_id_msg(env)
        @request_id_msg ||=
          begin
            request_id = env.request_headers['X-Request-Id']
            if request_id.to_s.size > 0
              "  (#{request_id})"
            else
              ""
            end
          end
      end

    end
  end
end
