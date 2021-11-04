# app/controllers/invites_controller.rb
class InvitesController < Invitation::InvitesController
  before_action :authorize

  private

  def authorize
    invitable = load_invitable
    invitable.can_invite?(current_user) or raise 'unauthorized'
  end

  def load_invitable
    invite_params[:invitable_type].classify.constantize.find(invite_params[:invitable_id])
  end
end
