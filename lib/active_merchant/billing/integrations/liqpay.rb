module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Liqpay 
        autoload :Helper, File.dirname(__FILE__) + '/liqpay/helper.rb'
        autoload :Notification, File.dirname(__FILE__) + '/liqpay/notification.rb'
        
       
        mattr_accessor :service_url
        self.service_url = 'https://liqpay.com/?do=clickNbuy'

        def self.notification(post)
          Notification.new(post)
        end  
      end
    end
  end
end
