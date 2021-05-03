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
        params.require(:event).permit(:event_id, :user_id)
    end

    def move_to_signed_in
        # userがサインインしているかチェック
        unless user_signed_in?
            flash[:notice] = "ログインして下さい"
            #サインインしていないユーザーはログインページが表示される
            redirect_to  new_user_session_path
        end
    end

end
