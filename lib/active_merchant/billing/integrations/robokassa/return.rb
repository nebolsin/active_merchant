module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Robokassa
        class Return < ActiveMerchant::Billing::Integrations::Return
          def order
            @params['InvId']
          end
          
          def amount
            @params['OutSum']
          end
	      end
      end
    end
  end
end
