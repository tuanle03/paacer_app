module Spree
  module Admin
    class AuditsController < Spree::Admin::BaseController
      def index
        @audits = Audited::Audit.order(created_at: :desc).limit(100)
      end
    end
  end
end
