class Api::V1::QiwiWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  # метод зарегистрирован как вебхук и должен получить параметры от киви, но почему то срабатывает
  def create
    payment_info = JSON.parse(request.body.read)

    if payment_info.present?
      render json: { message: 'Webhook received and processed successfully' }, status: :ok
    else
      render json: { error: 'Error processing webhook' }, status: :bad_request
    end
  end

  private
  
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
