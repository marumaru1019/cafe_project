class EventsController < InheritedResources::Base

  # before_action :authenticate

  # REALM = 'SecretZone'.freeze
  # USERS = { 'user1' => Digest::MD5.hexdigest(['user1', REALM, 'password'].join(':'))}.freeze

  include PutTime

  def top
    @events = Event.top5
  end

  def greeting
  end

  def index
    @events = Event.eager_load(:time_table).top30
    # future > past
    @events_after = @events.holded
    @events_before = @events.will_hold
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def search_by_place
    @events=Event.search_by_place(params[:search])
  end


  private

  # def authenticate
  #   authenticate_or_request_with_http_digest(REALM) do |username|
  #     USERS[username]
  #   end
  # end

  def event_params
    params
    .require(:event)
    .permit(:name, :date, :time_id, :recommend_menu, :recommend_menu_price, :place, :max_num, :comment, :store_url, :image)
  end
end
