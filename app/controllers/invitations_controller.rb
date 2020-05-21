class InvitationsController < ApplicationController
  def new
    @users = User.all
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(invitations_params[:event_id])
    @invitation = @event.invitations.build(guest_id: invitations_params[:user_id])
    if @invitation.save
      redirect_to event_path @event
    else
      flash[:notice] = 'This user could not be invited'
      redirect_to invitation_path @event
    end
  end

  private 

  def invitations_params
    params.permit(:event_id, :user_id)
  end

end
