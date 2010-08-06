require 'net/http'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Liqpay
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            status == 'success'
          end 

          def action_name 
            params['action_name'] # either 'result_url' or 'server_url'
          end
          
          def account
            params['merchant_id']
          end
          
          def item_id
            params['order_id']
          end

          def transaction_id
            params['transaction_id']
          end

          # When was this payment received by the client. 
          def version
            params['version']
          end

          def sender_phone
            params['sender_phone']
          end

          def security_key
            params['signature']
          end

          # the money amount we received in X.2 decimal.
          def gross
            params['amount']
          end
          
          def currency
            params['currency']
          end

          def status
            params['status'] # 'success', 'failure' or 'wait_secure'
          end
          
          def code
            params['code']
          end
          
          def generate_signature_string
            ['', version, @options[:secret], action_name, sender_phone, account, gross, currency, item_id, transaction_id, status, code, ''].flatten.compact.join('|')
          end
          
          def generate_signature
            Base64.encode64(Digest::SHA1.digest(generate_signature_string)).gsub(/\n/, '')
          end

          def acknowledge   
            security_key == generate_signature
          end
        end
      end
    end
  end
end
