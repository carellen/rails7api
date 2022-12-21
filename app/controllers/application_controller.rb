class ApplicationController < ActionController::API
  wrap_parameters false

  rescue_from Apipie::ParamInvalid, Apipie::ParamMissing do |exception|
    render json: {
      error: {
        type: 'invalid_request_error',
        message: exception.to_s
      }
    }, status: :bad_request
  end

  def authenticate_user!
    return if @current_user.present?

    auth = auth_provider.authenticate(token: auth_token)
    if auth[:error]
      render json: {
        error: {
          type: 'invalid_params_error',
          message: auth[:error]
        }
      }, status: :unauthorized
    else
      @current_user = auth[:result]
    end
  end

  def current_user
    @current_user ||= auth_provider.authenticate(token: auth_token)[:result]
  end

  def unauthorized
    render json: {
      error: {
        type: 'authorization_error',
        message: 'User is not allowed to perform this action'
      }
    }, status: :forbidden
  end

  def unprocessable(message: 'Unprocessable entity')
    render json: {
      error: {
        type: 'invalid_params_error',
        message: message
      }
    }, status: :unprocessable_entity
  end

  def record_not_found
    render json: {
      error: {
        type: 'invalid_params_error',
        message: 'Record not found'
      }
    }, status: :not_found
  end

  def route_not_found
    render json: {
      error: {
        type: 'invalid_request_error',
        message: "Unable to resolve the request: #{request.method} #{request.path}"
      }
    }, status: :not_found
  end

  def auth_provider
    Providers::JwtAuth
  end

  def auth_token
    if(header = request.headers['Authorization'])
      header.split(' ').last
    end
  end
end
