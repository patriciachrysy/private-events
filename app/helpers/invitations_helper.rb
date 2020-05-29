module InvitationsHelper
  def invite(user, event)
    return unless not_me(user) && already_invited_or_creator(user, event)

    render partial: 'invitations/invite_button', locals: { user: user }
  end

  def not_me(user)
    user.id != session[:current_user_id]
  end

  def already_invited_or_creator(user, event)
    user.invited_events.none? { |e| e.id == event.id } &&
      event.creator.id != user.id
  end
end
