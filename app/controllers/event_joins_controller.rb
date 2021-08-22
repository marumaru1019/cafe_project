class EventJoinsController < ApplicationController
    before_action :move_to_signed_in

    def create
        event = Event.find(params[:event_id])
        event_join = current_user.event_joins.new(event_id: event.id)
        event_join.save
        redirect_to event_path(event)
    end

    def destroy
        event = Event.find(params[:event_id])
        event_join = current_user.event_joins.find_by(event_id: event.id)
        event_join.destroy
        redirect_to event_path(event)
    end

    private

    def event_join_params
        params
        .require(:event_join)
        .permit(:event_id, :user_id)
    end
end
