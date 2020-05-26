module EventsHelper


  def invite_guests
    if session[:current_user] &&
      (am_invited? || my_event?)
      render '/invitations/list'
    end
  end

  def am_invited?
    @event.guests.include?(session[:current_user])
  end

  def my_event?
    session[:current_user_id] == @event.creator_id
  end

  def pending_event(event)
    if session[:current_user_id]
      render partial: '/events/event', locals: {event: event, invite: true}
    end 
  end
end
