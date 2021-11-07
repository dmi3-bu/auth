class Application < Sinatra::Base
  helpers Sinatra::CustomLogger
  include ::ApiErrors
  include Validations

  configure :development do
    register Sinatra::Reloader
    also_reload './app/**/*.rb'
    set :root, File.dirname(__FILE__)
    set :show_exceptions, false
  end

  post '/login' do
    session_params = validate_with!(SessionParamsContract, json_params)
    result = UserSessions::CreateService.call(*session_params.to_h.values)

    if result.success?
      token = JwtEncoder.encode(uuid: result.session.uuid)
      meta = { token: token }

      status :created
      json({ meta: meta })
    else
      error_response(result.session || result.errors, :unauthorized)
    end
  end

  post '/signup' do
    user_params = validate_with!(UserParamsContract, json_params)

    result = Users::CreateService.call(*user_params.to_h.values)

    if result.success?
      status :created
    else
      error_response(result.user, :unprocessable_entity)
    end
  end

  error ActiveRecord::RecordNotFound do
    error_response(I18n.t(:not_found, scope: 'api.errors'), :not_found)
  end

  error ActiveRecord::RecordNotUnique do
    error_response(I18n.t(:not_unique, scope: 'api.errors'), :unprocessable_entity)
  end

  error KeyError, JSON::ParserError, Validations::InvalidParams do
    error_response(I18n.t(:missing_parameters, scope: 'api.errors'), :unprocessable_entity)
  end

  def json_params
    JSON.parse(request.body.read).deep_symbolize_keys
  end
end
