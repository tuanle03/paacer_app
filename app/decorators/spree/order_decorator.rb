module Spree
  module OrderDecorator
    def self.prepended(base)
      base.audited
    end
  end
end

Spree::Order.prepend Spree::OrderDecorator
