module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Robokassa 
        autoload :Helper, File.dirname(__FILE__) + '/robokassa/helper.rb'
        autoload :Notification, File.dirname(__FILE__) + '/robokassa/notification.rb'
        autoload :Return, File.dirname(__FILE__) + '/robokassa/return.rb'
       
        mattr_accessor :service_url
        self.service_url = 'https://merchant.roboxchange.com/Index.aspx'

        def self.notification(post)
          Notification.new(post)
        end  
        
        def self.return(query_string)
          Return.new(query_string)
        end
      end
    end
  end
end
