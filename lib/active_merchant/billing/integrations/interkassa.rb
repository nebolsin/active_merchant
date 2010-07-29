module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Interkassa 
        autoload :Helper, File.dirname(__FILE__) + '/interkassa/helper.rb'
        autoload :Notification, File.dirname(__FILE__) + '/interkassa/notification.rb'
        autoload :Return, File.dirname(__FILE__) + '/interkassa/return.rb'
       
        mattr_accessor :service_url
        self.service_url = 'http://www.interkassa.com/lib/payment.php'

        def self.notification(post)
          Notification.new(post)
        end  
        
        def self.return(post)
          Return.new(post)
        end
      end
    end
  end
end
