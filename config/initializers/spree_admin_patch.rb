Rails.application.config.to_prepare do
  module Spree
    module Admin
      module BaseHelper
        def enterprise_edition?
          Rails.logger.info "[PATCHED] enterprise_edition? called"
          true
        end
      end
    end
  end
end
