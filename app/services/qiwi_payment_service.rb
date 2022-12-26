module QiwiPaymentService
  include HTTParty

  # выставление счета
  def create_bill(billId, value, phone, email, account, comment, paySourcesFilter, themeCode)
    response = HTTParty.put("https://api.qiwi.com/partner/bill/v1/bills/#{billId}",
      headers: {
        "Authorization" => "Bearer #{ENV['QIWI_SECRET_KEY']}",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      },
      body: {
        amount:  {
          value: value,
          currency: "RUB"
        },
        expirationDateTime: Time.now + 1.day,
        customer: {
          phone: phone,
          email: email,
          account: account
        },
        comment: comment,
        customFields: {
          paySourcesFilter: paySourcesFilter,
          themeCode: themeCode
        }
      }.to_json)
  end
end
