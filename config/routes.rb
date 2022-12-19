Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: Constraints::Api.new(version: 1, default: true) do
    end
  end

  match '*unmatched', to: 'application#route_not_found', via: :all
end
