class Api::V1::QiwiWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  include QiwiWebhookService

  # метод зарегистрирован как вебхук и должен получить параметры от киви, но почему то срабатывает
  def create
    payment_info = JSON.parse(request.body.read)

    if payment_info.present?
      payment = QiwiWebhookService.signature_processing(payment_info)

      render json: { message: 'Webhook received and processed successfully' }, status: :ok
    else
      render json: { error: 'Error processing webhook' }, status: :bad_request
    end
  end
end
