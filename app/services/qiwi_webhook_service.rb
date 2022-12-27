module QiwiWebhookService
  include HTTParty

  # Получение секретного ключа для расшифрофки цифровой подписи
  def get_webhook_key(hookId)
    base_url = "https://edge.qiwi.com/payment-notifier/v1/hooks/#{hookId}/key"
    headers = {
      Authorization: "Bearer #{ENV['QIWI_TOKEN']}",
      Accept: "application/json"
    }

    response = HTTParty.get(base_url, headers: headers)
  end

  # Регистрация обработчика вебхуков
  def create_webhook
    base_url = "https://edge.qiwi.com/payment-notifier/v1/hooks"
    headers = {
      Authorization: "Bearer #{ENV['QIWI_TOKEN']}",
      Accept: "application/json"
    }
    query_params = {
      hookType: 1,
      param: "example.com", # тут я использовал ngrok, вебхук регистрировался без проблем
      txnType: "2"
    }

    response = HTTParty.put(base_url, headers: headers, query: query_params)
  end

  # принимаем параметры и проверяем подпись уведомления
  # не уверен в этом методе и его наверняка нужно отлаживать, но я не могу получить параметры
  def signature_processing(payment_info)
    signature_key = # здесь должен быть ключ вебхука
    sign_fields = payment_info["payment"]["signFields"]
    values = sign_fields.map { |field| payment[field] }

    joined_values = values.join("|")

    hash = OpenSSL::HMAC.hexdigest("SHA256", signature_key, joined_values)

    hash == payment_info["hash"]
  end
end