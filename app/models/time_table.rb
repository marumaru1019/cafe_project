# == Schema Information
#
# Table name: events
#
#  id                                              :bigint(8)        not null, primary key
#  time(イベント時間)                                :text(65535)
#  created_at                                      :datetime         not null
#  updated_at                                      :datetime         not null
#
class TimeTable < ApplicationRecord
    # 時間が削除されてもイベントは残す
    has_many :events
    has_many :event_joins, dependent: :destroy
end
