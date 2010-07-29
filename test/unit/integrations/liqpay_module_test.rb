require 'test_helper'

class LiqpayModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations
  
  def test_notification_method
    assert_instance_of Liqpay::Notification, Liqpay.notification('name=cody')
  end
end 
