class ApplicationController < ActionController::API
  def route_not_found
    render json: {
      error: {
        type: 'invalid_request_error',
        message: "Unable to resolve the request: #{request.method} #{request.path}"
      }
    }, status: :not_found
  end
end
