module RequestHelpers
  def response_body
    JSON(last_response.body)
  end

  def auth_header(user)
    session = user.sessions.create!
    token = JwtEncoder.encode(uuid: session.uuid)

    "Bearer #{token}"
  end

  def json_request(uri, method, params: {})
    request = Rack::MockRequest.env_for(uri, method: method, params: params.to_json)
    request['CONTENT_TYPE'] = 'application/json'
    Application.call(request)
  end
end
