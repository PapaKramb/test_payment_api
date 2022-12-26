class Api::V1::QiwiPaymentsController < ApplicationController
  include QiwiPaymentService

  def create
    # по документации 4 обязательных параметра, но я решил указать все
    # billId = params[:billId]
    # value = params[:value]
    # expirationDateTime = params[:expirationDateTime]
    # phone = params[:phone]
    # email = params[:email]
    # account = params[:account]
    # comment = params[:comment]
    # paySourcesFilter = params[:paySourcesFilter]
    # themeCode = params[:themeCode]

    result = QiwiPaymentService.create_bill(billId, value, phone, email, account, comment, paySourcesFilter, themeCode)

    if result.success?
      render json: { status: "accepted" }, status: :ok
    else
      render json: { status: "rejected" }, status: :bad_request
    end
  end
end
