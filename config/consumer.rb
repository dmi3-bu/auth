channel = RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue('auth', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  token = begin
            matched_token = JSON.parse(payload)['token']
            JwtEncoder.decode(matched_token)
          rescue JWT::DecodeError
            {}
          end

  result = Auth::FetchUserService.call(token['uuid'])
  response = result.success? ? { meta: { user_id: result.user.id } } : {}

  exchange.publish(
    response.to_json,
    routing_key: properties.reply_to,
    correlation_id: properties.correlation_id
  )

  channel.ack(delivery_info.delivery_tag)
end
