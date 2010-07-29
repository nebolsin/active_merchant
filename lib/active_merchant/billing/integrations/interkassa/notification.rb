require 'net/http'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Interkassa
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            status == 'success'
          end 

          def account
            params['ik_shop_id']
          end
          
          def order
            params['ik_payment_id']
          end

          def transaction_id
            params['ik_trans_id']
          end

          def received_at
            params['ik_payment_timestamp']
          end

          def security_key
            params['ik_sign_hash']
          end
          
          def custom_fields
            params['ik_baggage_fields']
          end
          
          def currency
            params['ik_paysystem_alias']
          end
          
          def status
            params['ik_payment_state']
          end
          
          def exchange
            params['ik_currency_exch']
          end
          
          def fees_payer
            params['ik_fees_payer']
          end

          # the money amount we received in X.2 decimal.
          def gross
            params['ik_payment_amount']
          end

          def generate_md5_string
            [account, gross, order, currency, custom_fields, status, transaction_id, exchange, fees_payer, @options[:md5secret]].flatten.compact.join(':')
          end
          
          def generate_md5_signature
            Digest::MD5.hexdigest(generate_md5_string)
          end

          def acknowledge      
            security_key == generate_md5_signature.upcase
          end

 private

          # Take the posted data and move the relevant data into a hash
          def parse(post)
            @raw = post
            for line in post.split('&')
              key, value = *line.scan( %r{^(\w+)\=(.*)$} ).flatten
              params[key] = value
            end
          end
        end
      end
    end
  end
end
