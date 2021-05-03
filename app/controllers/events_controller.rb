class EventsController < InheritedResources::Base

  include PutTime

  def top
    @events = Event.top5
  end

  def greeting
  end

  def index
    @events = Event.top30
    # future > past
    @events_after = @events.holded
    @events_before = @events.will_hold
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :time_id, :recommend_menu, :recommend_menu_price, :place, :max_num, :comment, :store_url, :image)
  end

end
