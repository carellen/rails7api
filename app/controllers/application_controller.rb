class ApplicationController < ActionController::API
  def route_not_found
    render status: :not_found, json: {
      error: {
        type: 'invalid_request_error',
        message: "Unable to resolve the request: #{request.method} #{request.path}"
      }
    }
  end
end
