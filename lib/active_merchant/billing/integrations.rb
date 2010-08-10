# make the bogus gateway be classified correctly by the inflector
if defined?(ActiveSupport::Inflector)
  ActiveSupport::Inflector.inflections do |inflect|
    inflect.uncountable 'bogus'
  end
else
  Inflector.inflections do |inflect|
    inflect.uncountable 'bogus'
  end
end

module ActiveMerchant
  module Billing
    module Integrations
      mattr_accessor :integrations
      self.integrations = []

      Dir[File.dirname(__FILE__) + '/integrations/*.rb'].each do |f|
        # Get camelized class name
        filename = File.basename(f, '.rb')

        integrations << filename.to_sym unless ['action_view_helper', 'helper', 'notification', 'return'].include?(filename)

        # Camelize the string to get the class name
        gateway_class = filename.camelize.to_sym

        # Register for autoloading
        autoload gateway_class, f
      end

      def self.integration(name)
        if self.integrations.include?(name.to_sym)
          self.const_get(name.to_s.classify)
        end
      end

      # integration module (such as ActiveMerchant::Billing::Integrations::Robokassa) which can
      # recognize given set of params
      def self.recognize(params)
        ActiveMerchant::Billing::Integrations.integrations.each do |integration_code|
          integration = ActiveMerchant::Billing::Integrations.integration(integration_code)
          return integration_code, integration if integration.const_get('Notification').recognizes?(params)
        end
      end

    end
  end
end
