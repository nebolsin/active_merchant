module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Robokassa
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            true
          end
          
          def item_id
            params['InvId']
          end

          def security_key
            params['SignatureValue']
          end

          def gross
            params['OutSum']
          end

          def generate_signature_string
            main_params = [item_id, gross]
            custom_param_keys = params.keys.select {|key| key =~ /^shp/}.sort
            custom_params = custom_param_keys.map {|key| "#{key}=#{params[key]}"}
            [main_params, @options[:secret], custom_params].flatten.compact.join(':')
          end
          
          def generate_signature
            Digest::MD5.hexdigest(generate_signature_string)
          end

          def acknowledge    
            security_key == generate_signature
          end
        end
      end
    end
  end
end
