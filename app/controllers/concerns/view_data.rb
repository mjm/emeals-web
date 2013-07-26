module ViewData
  extend ActiveSupport::Concern

  included do
    def self.data(method_name, &block)
      ivar = "@#{method_name}"
      define_method method_name do
        instance_variable_get(ivar) || instance_variable_set(ivar, instance_eval(&block))
      end
      helper_method method_name
      protected method_name
    end
  end
end
