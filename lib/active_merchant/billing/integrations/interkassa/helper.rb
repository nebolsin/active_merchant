module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Interkassa
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          def initialize(order, account, options = {})
            @md5secret = options.delete(:md5secret)
            
            super
          end

          def form_fields
            @fields.merge('ik_sign_hash' => generate_md5_signature)
          end
            
          def generate_md5_string
            main_params = [:account, :amount, :order, :currency, :custom_fields].map {|key| @fields[mappings[key]]}
            [main_params, @md5secret].flatten.compact.join(':')
          end
          
          def generate_md5_signature
            Digest::MD5.hexdigest(generate_md5_string).upcase
          end
          
          # Replace with the real mapping
          mapping :account, 'ik_shop_id'
          mapping :amount, 'ik_payment_amount'
        
          mapping :order, 'ik_payment_id'
          mapping :currency, 'ik_paysystem_alias'

          mapping :notify_url, 'ik_status_url'
          mapping :return_url, 'ik_success_url'
          mapping :cancel_return_url, 'ik_fail_url'
          mapping :description, 'ik_payment_desc'
          
          mapping :custom_fields, 'ik_baggage_fields'
        end
      end
    end
  end
end
