module Spree
  module Admin
    class AuditsController < Spree::Admin::BaseController
      def index
        @audits = Audited::Audit.order(created_at: :desc).page(params[:page]).per(25)
      end
    end
  end
end
