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
end