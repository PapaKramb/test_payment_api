Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :qiwi_payments
      post '/qiwi_webhooks/create', to: 'qiwi_webhooks#create'
    end
  end
end
