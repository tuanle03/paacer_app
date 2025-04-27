module Spree
  module ProductDecorator
    def self.prepended(base)
      base.audited
    end
  end
end

Spree::Product.prepend Spree::ProductDecorator
