module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Liqpay
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          def initialize(order, account, options = {})
            super

            add_field 'version', '1.1'
          end

          mapping :account, 'merchant_id'
          mapping :amount, 'amount'
          mapping :currency, 'currency'
          mapping :order, 'order_id'
          mapping :description, 'description'

          mapping :notify_url, 'server_url'
          mapping :return_url, 'result_url'
        end
      end
    end
  end
end
