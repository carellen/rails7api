module Constraints
  class Api
    def initialize(version:, default: false)
      @version = version
      @default = default
    end

    def matches?(req)
      @default || req.headers['Accept'].include?("application/vnd.app.v#{@version}")
    end
  end
end
