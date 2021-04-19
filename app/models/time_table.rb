class TimeTable < ApplicationRecord
    # 時間が削除されてもイベントは残す
    has_many :events
    has_many :event_joins, dependent: :destroy
end
