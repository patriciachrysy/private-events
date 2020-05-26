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

  def pending_events(pending_events)
    if pending_events.any?
      pending_events.each do |event| 
        
          render 'event'

          link_to 'Accept invitation', 
          {controller: "events", 
           action: "attend_event", 
           event_id: event.id}, 
           class: "btn btn-success" 
      end 
    end 
  end
end
