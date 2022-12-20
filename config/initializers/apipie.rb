default_version = '1.0'

Apipie.configure do |config|
  config.app_name = 'Rails 7 API'
  config.app_info[default_version] = 'Base API template using Rails 7'
  config.api_base_url[default_version] = ''
  config.doc_base_url = '/apidocs'
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  config.default_version = default_version
end
