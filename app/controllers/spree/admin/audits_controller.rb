module Spree
  module Admin
    class AuditsController < Spree::Admin::BaseController
      def index
        audits_scope = Audited::Audit.order(created_at: :desc)

        if params[:q].present?
          audits_scope = audits_scope.where(
            auditable_id: params[:q][:auditable_id_eq],
            auditable_type: params[:q][:auditable_type_eq]
          )
        end

        @audits = audits_scope.page(params[:page]).per(21)
      end
    end
  end
end
