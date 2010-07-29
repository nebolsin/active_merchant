module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Robokassa
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            true
          end
          
          def order
            params['InvId']
          end

          def security_key
            params['SignatureValue']
          end

          def gross
            params['OutSum']
          end

          def generate_md5_string
            main_params = [order, gross]
            custom_param_keys = params.keys.select {|key| key =~ /^shp/}.sort
            custom_params = custom_param_keys.map {|key| "#{key}=#{params[key]}"}
            [main_params, @options[:md5secret], custom_params].flatten.compact.join(':')
          end
          
          def generate_md5_signature
            Digest::MD5.hexdigest(generate_md5_string)
          end

          def acknowledge      
            security_key == generate_md5_signature
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
