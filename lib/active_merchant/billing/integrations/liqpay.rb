module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      
      # Documentation: https://www.liqpay.com/?do=pages&p=cnb10
      module Liqpay 
        autoload :Helper, File.dirname(__FILE__) + '/liqpay/helper.rb'
        autoload :Notification, File.dirname(__FILE__) + '/liqpay/notification.rb'
        
       
        mattr_accessor :service_url
        self.service_url = 'https://liqpay.com/?do=clickNbuy'

        def self.notification(query_string, options = {})
          Notification.new(query_string, options)
        end  
      end
    end
  end
end
